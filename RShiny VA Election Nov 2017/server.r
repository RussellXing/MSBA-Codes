library(shiny)
library(leaflet)
library(dplyr)
library(geojsonio)
library(ggplot2)

dataset <- read.table(paste(getwd(), "/results.txt", sep=""), header = TRUE, sep = ",", stringsAsFactors = FALSE)
dataset[is.na(dataset$total_votes),]$total_votes <- 0
dataset[dataset$locality_name == "KING & QUEEN COUNTY",]$locality_name <- "KING AND QUEEN COUNTY"
locality <- distinct(dataset,locality_name)
office <- distinct(dataset,office_name)
vacounties <- geojson_read(paste(getwd(), "/vacounties.json", sep=""), what = "sp")
county <- as.character(vacounties$name)
for (i in 1:134){
  county[i] <- toupper(substr(county[i],1,nchar(county[i])-4))
}
counties <- as.data.frame(county)

shinyServer(function(input, output){
  
  output$v1 <- renderText(input$Office1)
  
  output$v2 <- renderText(input$`County/City`)
## Calculate the election results by county and office  
  table_result <- reactive({
    result_state <- dataset %>%
      filter(office_name == input$Office1, candidate_name != 'Write In') %>%
      group_by(office_name, party, candidate_name) %>%
      summarise(votes_state = sum(total_votes)) %>%
      select(office_name, party, candidate_name, votes_state)
  
    total_state <- dataset %>%
      filter(office_name == input$Office1) %>%
      group_by(office_name) %>%
      summarise(total_votes_sate = sum(total_votes)) %>%
      select(office_name, total_votes_sate)
    
    result_county <- dataset %>%
      filter(office_name == input$Office1, locality_name == input$`County/City`, candidate_name != 'Write In') %>%
      group_by(office_name, party, candidate_name) %>%
      summarise(votes_county = sum(total_votes)) %>%
      select(office_name, party, candidate_name, votes_county)
    
    total_county <- dataset %>%
      filter(office_name == input$Office1, locality_name == input$`County/City`, candidate_name != 'Write In') %>%
      group_by(office_name) %>%
      summarise(total_votes_county = sum(total_votes)) %>%
      select(office_name, total_votes_county)
    
    result_county %>%
      left_join(total_county, by = "office_name") %>%
      mutate(vote_rate = paste(round(votes_county/total_votes_county*100, 2), "%", sep = "")) %>%
      left_join(result_state, by = c("office_name","party","candidate_name")) %>%
      left_join(total_state, by = "office_name") %>%
      mutate(total_vote_rate = paste(round(votes_state/total_votes_sate*100, 2), "%", sep = "")) %>%
      select(office_name, party, candidate_name, votes_county, vote_rate, total_vote_rate)
  })
  
#Calculate the vote number and result of Democratic Party by county and result  
  democratic_result <- reactive({
    state_election1 <- dataset %>%
      filter(office_name == input$Office2) %>%
      group_by(locality_name, party) %>%
      summarise(votes = sum(total_votes))
    
    state_election2 <- dataset %>%
      filter(office_name == input$Office2) %>%
      group_by(locality_name) %>%
      summarise(total = sum(total_votes))
    
    state_election_D <- state_election1 %>%
      left_join(state_election2, by = "locality_name") %>%
      mutate(rate = round(votes/total, 2), rate_county = "") %>%
      filter(party == "Democratic") %>%
      select(county = locality_name, rate, rate_county)
    
    for(i in 1:nrow(state_election_D)){if(state_election_D$county[i] == input$`County/City2`){state_election_D$rate_county[i] <- input$`County/City2`}}
    
    counties$county <- as.character(counties$county)
    
    state_election_D$county <- as.character(state_election_D$county)
    
    state_election_D <- left_join(counties,state_election_D, by = "county")
    
    state_election_D[is.na(state_election_D$rate),]$rate <- 0
    
    state_election_D
  })
  
  #Calculate the vote number and result of Democratic Party by county and result  
  republican_result <- reactive({
    state_election1 <- dataset %>%
      filter(office_name == input$Office2) %>%
      group_by(locality_name, party) %>%
      summarise(votes = sum(total_votes))
    
    state_election2 <- dataset %>%
      filter(office_name == input$Office2) %>%
      group_by(locality_name) %>%
      summarise(total = sum(total_votes))
    
    state_election_R <- state_election1 %>%
      left_join(state_election2, by = "locality_name") %>%
      mutate(rate = round(votes/total, 2), rate_county = "") %>%
      filter(party == "Republican") %>%
      select(county = locality_name, rate, rate_county)
    
    for(i in 1:nrow(state_election_R)){if(state_election_R$county[i] == input$`County/City2`){state_election_R$rate_county <- input$`County/City2`}}
    
    counties$county <- as.character(counties$county)
    
    state_election_R$county <- as.character(state_election_R$county)
    
    state_election_R <- left_join(counties,state_election_R, by = "county")
    
    state_election_R[is.na(state_election_R$rate),]$rate <- 0
    
    state_election_R
  })
  
  ##output the result table
  output$results <- renderTable(
    table_result()
  )
  
  ##output the pie chart
  output$pie <- renderPlot({
    if (table_result()$office_name == "Member House of Delegates"){
      ggplot(table_result(), aes(x = "", y = votes_county, fill = party)) + geom_bar(stat = "identity") + coord_polar(theta = "y")
    }
    else{
      ggplot(table_result(), aes(x = "", y = votes_county, fill = party)) + geom_bar(stat = "identity") + coord_polar(theta = "y") + geom_text(aes(label = candidate_name))
    }
  })
  
  ##output the maps
  output$map_d <- renderLeaflet({
    binpal <- colorBin("Blues", democratic_result()$rate, input$`Color levels`, pretty = FALSE)
    
    leaflet(vacounties) %>%
      addTiles() %>%
      addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                  fillColor = ~binpal(democratic_result()$rate),
                  label = ~paste0(democratic_result()$county, ": ", democratic_result()$rate)) %>%
      addLegend(pal = binpal, values = democratic_result()$rate, opacity = 1.0)
  })
  
  output$map_r <- renderLeaflet({
    binpal <- colorBin("Reds", republican_result()$rate, input$`Color levels`, pretty = FALSE)
    
    leaflet(vacounties) %>%
      addTiles() %>%
      addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                  fillColor = ~binpal(republican_result()$rate),
                  label = ~paste0(republican_result()$county, ": ", republican_result()$rate)) %>%
      addLegend(pal = binpal, values = republican_result()$rate, opacity = 1.0)
  })
  
  party_result <- reactive({
    d <- democratic_result() %>%
      select(county, rate_D = rate, rate_county)
    
    r <- republican_result() %>%
      select(county, rate_R = rate)
    
    party <- r %>%
      left_join(d) %>%
      mutate(diff = rate_D - rate_R, win = "2_Democratic")
    
    for (i in 1:nrow(party)){if (party$diff[i] < 0) {party$win[i] = "1_Republican"}}
    
    party[is.na(party$rate_county),]$rate_county <- ""
    
    party %>%
      select(rate_D, rate_R, rate_county, win)
  })
  
  ## output the scatter plots
  output$scatter <- renderPlot({
    ggplot(party_result(), aes(x = rate_D, y = rate_R, colour = win)) + geom_point() + geom_text(aes(label = rate_county), size=4)
  })
  
})