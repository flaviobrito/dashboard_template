library(shiny)
library(shinydashboard)

# Simple header -----------------------------------------------------------

dm <- dropdownMenu(type = "messages")
mm <- dropdownMenu(type = "notifications")
tm <- dropdownMenu(type = "tasks")

#header <- dashboardHeader(title="SEPLAG - Dashboard", dm, mm, tm)

# sample
# Dropdown menu for messages
header <- dashboardHeader(
  title = "SEPLAG - Dashboard",
  dropdownMenu(
    type = "messages",
    badgeStatus = "success",
    messageItem("Equipe de Suporte",
                "Mensagem exemplo",
                time = "5 mins"),
    messageItem("Equipe de Suporte",
                "Nova mensagem.",
                time = "2 hours"),
    messageItem("Novo usuário",
                "Alguma ajuda?",
                time = "Today")
  ),
  # Dropdown menu for notifications
  dropdownMenu(
    type = "notifications",
    badgeStatus = "warning",
    notificationItem(
      icon = icon("users"),
      status = "info",
      "5 novos membros hoje"
    ),
    notificationItem(
      icon = icon("warning"),
      status = "danger",
      "Uso dos recursos no limite."
    ),
    notificationItem(
      icon = icon("shopping-cart", lib = "glyphicon"),
      status = "success",
      "30 processos iniciados"
    ),
    notificationItem(
      icon = icon("user", lib = "glyphicon"),
      status = "danger",
      "Você mudou seu nome"
    )
  ),
  # Dropdown menu for tasks, with progress bar
  dropdownMenu(
    type = "tasks",
    badgeStatus = "danger",
    taskItem(value = 20, color = "aqua",
             "Refatoração de código"),
    taskItem(value = 40, color = "green",
             "Design de novo layout"),
    taskItem(value = 60, color = "yellow",
             "Outra tarefa"),
    taskItem(value = 80, color = "red",
             "Documentação")
  )
)

# end of the sample
# No sidebar --------------------------------------------------------------

sm <- sidebarMenu(menuItem(
  text = "Menu",
  tabName = "main",
  icon = icon("eye")
))

sidebar <- dashboardSidebar(sm)

# Compose dashboard body --------------------------------------------------
#####
## Body content
# Associate dashboardBody to a variable
#########################
bd <- dashboardBody(tabItems(
  # First tab content
  tabItem(tabName = "dashboard",
          fluidRow(
            box(plotOutput("plot1", height = 250)),
            box(
              title = "Controls",
              sliderInput("slider", "Número de observações:", 1, 100, 50)
            )
          )),
  # Second tab content
  tabItem(tabName = "widgets",
          h2("Objetos"))
))
#####
#New feature associating a variable
# I included cause an error appears indicating that "ui not found"
body <- dashboardBody(bd)
#ending inluded new code

# Setup Shiny app UI components -------------------------------------------

ui <- dashboardPage(header, sidebar, body, skin = "black")

# Setup Shiny app back-end components -------------------------------------

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
}
shinyApp(ui, server)
