
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinydashboard)
library(shinyBS)
library(shinyalert)
dbHeader <- dashboardHeader(title = "TLC-MS_manager")

dashboardPage(
  dbHeader,
  dashboardSidebar(
    sidebarMenu(
                menuItem("Connection", tabName = "Connect",icon=icon("home")),
                menuItem("TLC-MS",tabName = "TLC_MS",icon=icon("spoon")),
                menuItem("GCODE upload", tabName = "test_ink",icon=icon("wrench")),
                menuItem("Read me",tabName = "About",icon=icon("info"))
    )
  ),
  
  dashboardBody(
    tags$script(HTML("$('body').addClass('sidebar-mini');")),
    tabItems(
      tabItem(
        tags$head(tags$style(type="text/css", "tfoot {display: table-header-group}")),
        tags$head(tags$style(type="text/css", "tfoot {display: table-header-group}")),
        tags$head(tags$style(HTML(".shiny-output-error-validation {color: red;font-size: 24px}"))),
        tags$head(tags$style(type="text/css", ".shiny-progress .progress {position: absolute;width: 100%;top: 100px;height: 10px;margin: 0px;}")),
        tags$head(tags$style(type="text/css", ".shiny-progress .progress-text {position: absolute;border-style: solid;
                                     border-width: 2px;right: 10px;height: 36px;width: 50%;background-color: #EEF8FF;margin: 0px;padding: 2px 3px;opacity: 1;}"))
      ),
      # First tab content
      tabItem(tabName = "Connect",
              column(4,
                     h4("Login"),
                     uiOutput("Login"),
                     textInput("Info","Project info, id or whatever","test"),
                     useShinyalert()
              ),
              column(4,
                     h4("Board"),
                     actionButton("Serial_port_refresh","Refresh serial port",icon=icon("refresh")),
                     checkboxInput("Serial_windows","Windows ??",F),
                     uiOutput("Serial_portUI"), # show the /dev directory
                     uiOutput("Serial_port_connectUI") # show an actionButton only if connect$login is TRUE and set connect$board to TRUE
              ),
              actionButton("Shutdown","Shutdown"),
              actionButton("Reboot","Reboot")
              
              ),
      # First tab content
      tabItem(tabName = "test_ink",
              uiOutput("ink_test_control_1")
      ),

      tabItem(tabName = "TLC_MS",
              uiOutput("TLC_MS_control_1")
      ),

      tabItem(tabName = "Log",
              actionButton("Log_refresh","refresh"),
              dataTableOutput("Log")
      ),
      tabItem("About",
              includeMarkdown("README/README_manual.md")
      )
    )
  )
)
