colors = ["White Glass","Red Glass","Blue Glass","Steel/HDPE"];

redLit = 0;
redBig = 0;
blueLit = 0;
blueBig = 0;
whiteLit = 0;
whiteBig = 0;
Steel = 0;
antiVi = 0;


for i = 1:4
   switch ColorList(i)
       case "White Glass"
           whiteLit = whiteLit + Type1List(i);
           whiteBig = whiteBig + Type2List(i);
       case "Red Glass"
           redLit = redLit + Type1List(i);
           redBig = redBig + Type2List(i);
       case "Blue Glass"
           blueLit = blueLit + Type1List(i);
           blueBig = blueBig + Type2List(i);
       case "Steel/HDPE"
           steel = steel + Type1List(i);
           antiVi = antiVi + Type2List(i);
   end
   
end