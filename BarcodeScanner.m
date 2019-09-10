clear %clears all data for future use

%register the brick, motor, and sensor
mylego = legoev3('usb');
mymotor = motor(mylego,'A');
myColor = colorSensor(mylego,3);
button = touchSensor(mylego,1);

clearLCD(mylego)

binCode = ''; %holds the full binary code
color = ''; %holds the last 3 numbers of bin
typeCount = ''; %holds the first 5 numbers of bin

%The possible materials and their respective codes
colors = ["White Glass","Red Glass","Blue Glass","Steel/HDPE"];
colorcodes = ["001","010","011","100"];

%The possible number pairs of each type and their respective codes
type1 = [0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3];
type2 = [0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3];
typeCodes = ["00001","00010","00011","00100","00101","00110","00111","01000","01001","01010","01011","01100","01101","01110","01111","10000"];

%Will hold the master lists for each step of adding marbles
ColorList = [];
Type1List = [];
Type2List = [];

mymotor.Speed = 5;
start(mymotor)

while length(ColorList) < 4
mymotor.Speed = 5;
%This will keep running until manual shutoff
    writeLCD(mylego,readColor(myColor))
    while(readColor(myColor) ~= "black")
        if(readTouch(button) == 1)
            break
        end
        writeLCD(mylego,readColor(myColor))
    end
    %At this point, the sensor is waiting for a barcode to slide in
    
    if(readTouch(button) == 1)
            break
    end

    i = 8;
    
    mymotor.Speed = 0;
    pause(1)

    while i > 0 %it reads 8 times
        mymotor.Speed = 5;
        pause(.93) %lets it scroll through the barcode each time
        mymotor.Speed = 0;
        %reads the color and adds the approriate number to the binary code for the barcode
        if(readColor(myColor) ~= "white")
            binCode = strcat('1',binCode);
        else
            binCode = strcat('0',binCode);
        end
        disp(binCode)
        i = i - 1;
        pause(1)
    end

    %binCode = strcat('0',binCode);
    disp(binCode)
    
    color = binCode(6:8); %the last 3 numbers; the color code for the marble wanted
    typeCount = binCode(1:5); %the first 5 numbers; the type code for the wanted number of each type

    %adds the material and type counts to a list of all of them, to be read step by step
    if find(colorcodes == color) > 0
        ColorList = [ColorList, colors(find(colorcodes == color))];
        disp(colors(find(colorcodes == color)))
    else
        disp('Error: Please Scan Again')
    end
    if find(typeCodes == typeCount) > 0
        Type1List = [Type1List, type1(find(typeCodes == typeCount))];
        Type2List = [Type2List, type2(find(typeCodes == typeCount))];
        disp(type1(find(typeCodes == typeCount)))
        disp(type2(find(typeCodes == typeCount)))
    else
        disp('Error: Please Scan Again')
    end    
    
    binCode = '';
    color = '';
    typeCount = '';
    
    if(readTouch(button) == 1)
            break
    end

end

mymotor.Speed = 0;

if(readTouch(button) == 1)
    BarcodeWorkaround()
else
    InterperetBarcode()
end

        
    
