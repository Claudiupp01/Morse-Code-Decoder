clc
load data.mat

%decode sound to morse

	%your code goes here!!!
	

%decode morse to text (do not change this part!!!)
%mCode = '-.. ... .--. .-.. .- -... ... ';
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