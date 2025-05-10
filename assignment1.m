function assignment1(input_wavefile_path)
clc
load data.mat

%decode sound to morse

	%your code goes here!!!
    
    [yIN Fs] = audioread(input_wavefile_path);
    
    timp = length(yIN)/Fs;
    
    %durata = cate elemente sunt !=0 si impartim cu Fs
    
    contorDiferitDe0 = 0;
    contorEgalCu0 = 0;
    a = 0;
    
    mCode = '';
    
    for i=1:length(yIN)

        if(i == 1)
            contorDiferitDe0 = contorDiferitDe0 + 1;
            a = 0; %avem caracter

        elseif(i == length(yIN))
            mCode = [mCode ' ']
       
        elseif(yIN(i) ~= 0 && a == 0)
            contorDiferitDe0 = contorDiferitDe0 + 1;
            a = 0; % avem caracter
            
        elseif(yIN(i) == 0 && a == 0)
            a = 1; % avem spatiu
            contorEgalCu0 = contorEgalCu0 + 1;
            
            %disp('caracter');
            
            secventa = contorDiferitDe0 / Fs;
            disp(secventa);
            
            if(round(secventa*100)/100 == round(0.1000*100)/100) % avem punct
                mCode = [mCode '.'];
            elseif(round(secventa*100)/100 == round(0.3000*100)/100) % avem linie
                mCode = [mCode '-'];
            end
            
            %disp(mCode);
            
            contorDiferitDe0 = 0;
            
        elseif(yIN(i) == 0 && a == 1)
            contorEgalCu0 = contorEgalCu0 + 1;
            a = 1; % avem spatiu
            
            %contorDiferitDe0 = 0;
                
        elseif(yIN(i) ~= 0 && a == 1)
            a = 0; % avem caracter
            contorDiferitDe0 = contorDiferitDe0 + 1;
            
            secventa = contorEgalCu0 / Fs;

            %disp('spatiu');
            disp(secventa);
            
            if(round(secventa*100)/100 == round(0.1000*100)/100) % avem spatiu intre simboluri
                mCode = [mCode ''];
            elseif(round(secventa*100)/100 == round(0.3000*100)/100) % avem spatiu intre caractere
                mCode = [mCode ' '];
            elseif(round(secventa*100)/100 == round(0.7000*100)/100)
                mCode = [mCode,'/'];
            end
            
            contorEgalCu0 = 0;
            
        end
           
    end
    
    disp(timp);
    
    plot(yIN);

    disp('mCode = ');
    disp(mCode);
    
    
	

%decode morse to text (do not change this part!!!)
%mCode = '-.. ... .--. .-.. .- -... ... '; %DSPLABS
deco = [];
mCode = [mCode ' '];	%mCode is an array containing the morse characters to be decoded to text
lCode = [];

for j=1:length(mCode)
    if(strcmp(mCode(j),' ') || strcmp(mCode(j),'/'))
        for i=double('a'):double('z')
            letter = getfield(morse,char(i));
            if strcmp(lCode, letter)
                deco = [deco char(i)];
            end
        end
        for i=0:9
            numb = getfield(morse,['nr',num2str(i)]);
            if strcmp(lCode, numb)
                deco = [deco, num2str(i)];
            end
        end
        lCode = [];
    else
        lCode = [lCode mCode(j)];
    end
    if strcmp(mCode(j),'/')
        deco = [deco ' '];
    end
end

fprintf('Decode : %s \n', deco);

end