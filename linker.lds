SECTIONS {
  . = 0x10000;
  .text : {
    main.o (.text); 
    * (.text);
  }
}
