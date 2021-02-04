## server_Fine_control.R

output$ink_test_control_1 = renderUI({
  tagList(
    column(3,
           h4("General"),
           textInput("test_ink_cmd","Command","G1 X10"),
           actionButton("test_ink_cmd_button","Launch GCODE"),
           # actionButton("test_ink_G28_X0","Home X"),
           # actionButton("test_ink_G28_Y0","Home Y"),
           # actionButton("test_ink_G28_Z0","Home Z"),
           actionButton("test_ink_M84","Disable Motors")
           # uiOutput("temp_1"),
           # actionButton("test_ink_LED","LED gcode in pin 63 (for testing only)"),
           # actionButton("test_ink_LED_stop","Stop_LED (for testing only)")
    ),
    column(3,
           h4("Gcode upload"),
           fileInput("test_ink_gcode_file","Upload a GCODE file"),
           actionButton("test_ink_gcode_file_action","Launch the GCODE file")
    )
  )
})
test_ink_gcode <- reactive({
  # paste0("M700 P0 I",input$test_ink_n_bis," S",input$test_ink_S)
  # rep(paste0("M700 P0 S",input$test_ink_S),input$test_ink_n)
  S=rep(0,12)
  for(i in seq(12)){if(i %in% as.numeric(input$test_ink_S)){S[i] = 1}};S = BinToDec(S)
  rep(paste0("M700 P0 I",input$test_ink_n_bis," L",input$test_ink_L," S",S),input$test_ink_n)
})
observeEvent(input$test_ink_cmd_button,{
  if(connect$board){
    # create the gcode
    test_ink_file = "gcode/test_ink_cmd.gcode"
    Log = test_ink_file
    fileConn<-file(test_ink_file)
    writeLines(input$test_ink_cmd, fileConn)
    close(fileConn)  # send the gcode
    main$send_gcode(test_ink_file)
  }else{
    shinyalert(title = "Error",text = "Board not connected",type="error",closeOnClickOutside = T, showCancelButton = F)
  }
})
observeEvent(input$test_ink_M84,{
  if(connect$board){
  # create the gcode
  test_ink_file = "gcode/test_ink_cmd.gcode"
  Log = test_ink_file
  fileConn<-file(test_ink_file)
  writeLines("M84", fileConn)
  close(fileConn)  # send the gcode
  main$send_gcode(test_ink_file)
  }else{
    shinyalert(title = "Error",text = "Board not connected",type="error",closeOnClickOutside = T, showCancelButton = F)
  }
})
