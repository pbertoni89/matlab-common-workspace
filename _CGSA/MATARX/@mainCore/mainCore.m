% this class contains the basic method of the software: create model
% and predict. 
classdef mainCore
    properties (SetAccess='public' , GetAccess='public')
    end
    
    methods
    end
    
    methods (Static)
        %this method create a model for each element of datiModelli
        % where orderY is the order of the Y and orderU is a verctor
        % containing the order of each input
        % if cutOrNot is 1 it cut the nan to create model, else it doesnt
        % cut the A and it's used to return the A for the prediction
        function [model,A] = createModel(dataModel, orderY, orderU, cutOrNot)
            % for each dataModel
            for k=1:length(dataModel)
                % calculate the number of input u
                numberU=length(orderU);
                % calculate when to stop
                maxU=max(orderU);
                M=max(orderY,maxU);
                % get the y from the input
                y=dataModel{k}.outputdata;
                % get the value of u
                u=dataModel{k}.inputdata;
                
                ly=length(y);
                Ay=zeros(ly-M,orderY);
                % from 1 to n
                for i=1:orderY
                    Ay(1:end,i)=y(ly-i:-1:M-i+1);
                end
                
                AuFinal=[];
                % from 1 to how manu input i have
                orderU=orderU;
                lengthU=length(orderU);
                
                % this part create the u part of the model
                for j=1:length(orderU)
                    Au=zeros(ly-M,orderU(j));
                    % 
                    for i=1:orderU(j)
                        % the length of the corresponding input
                        lu=length(u(:,j));
                        Au(1:end,i)=u(lu-i:-1:M-i+1,j);
                    end
                    AuFinal=[AuFinal,Au];
                end
                % this part create the ones used to balance the system
                Aone=ones(ly-M,1);
                % this part merge the data into a unique matrix A
                A{k}=[Ay,AuFinal,Aone];
                y1=y(length(y):-1:M+1);
                
                if (cutOrNot==1)
                    % this part is used to remove the NaN from the model
                    % to the A and the y1
                    tmpsum=sum(A{k},2);

                    delvect=zeros(length(A{k}),1); % the vector used to see if i need to delete the element
                    for i=1:length(A{k}) % A have same length of y1
                        if(isnan(tmpsum(i)) || isnan(y1(i))) % the elemen need to be removed
                            delvect(i)=1;
                        else
                            %delvect(i)=0;
                        end
                    end
                    tmpa=[];
                    tmpy=[];
                    for i=1:length(delvect)
                        if(delvect(i)==1) % the element need to be removed
                            ;
                        else
                            tmpa=[tmpa;A{k}(i,:)];
                            tmpy=[tmpy;y1(i)];
                        end
                    end
                    y1=tmpy;
                    A{k}=tmpa;
                    
                    % create the model for each stazionarety
                    model{k}=pinv(A{k})*y1;
                else
                    model=[];
                end%end if
            end %end for
        end %end function
        
        
        % return the prediction or the model depending on variable
        % predModel if predModel=1 return model else return prediction
        % tempdata and temppred are used for the statistics
        function [result, tempdata, tempred] = predict(predModel, model, dataInput,period,internalStat,orderY,orderU,nStep,delayU1,delayU2,misvalue)
            result=[];
            tempdata=[];
            tempred=[];
            u=orderU;
            internalStat=internalStat'; % for data patchwork
            
            % create data to validate and validation vector
            %[validateVectY,dataVectY]=service.valVector(dataInput.outputdata,nStep);
            
            %% part1: prepare the data
            % create the new dataInput object
            if(u(1)==0 && u(2)>0 ) % u2 only
                % calculate the delay
                dataInput.inputdata=service.delay(dataInput.inputdata,delayU2);
               % [validateVectU2,dataVectU2]=service.valVector(dataInput.inputdata,nStep);
                %dataInput=iddata(dataVectY,dataVectU2);
            elseif(u(2)==0 && u(1)>0) % u1 only
                %calculate delay
                dataInput.inputdata=service.delay(dataInput.inputdata,delayU1);
                %[validateVectU1,dataVectU1]=service.valVector(dataInput.inputdata,nStep);
                %dataInput=iddata(dataVectY,dataVectU1);
                
            elseif(u(2)>0 && u(1)>0) % u1 and u2
                %calculate delay
                input(:,1)=service.delay(dataInput.inputdata(:,1),delayU1);
                input(:,2)=service.delay(dataInput.inputdata(:,2),delayU2);
                dataInput.inputdata=input;
                %[validateVectU1,dataVectU1]=service.valVector(dataInput.inputdata(:,1),nStep);
                %[validateVectU2,dataVectU2]=service.valVector(dataInput.inputdata(:,2),nStep);

                
              %  dataInput=iddata(dataVectY,[dataVectU1 dataVectU2]);
            else % no u1 and no u2
               % dataInput=iddata(dataVectY,dataInput.inputdata);
            end
            
            %% part2 if needed create the model
            if (predModel==1) % if i  have only to return the model
                
                if (isempty(period) || isempty(internalStat) || period==0 ) % no stazionariety
                    dataNew1{1}=dataInput;
                    [model,A]=mainCore.createModel(dataNew1,orderY,u,1);
                else
                    datiModelli=service.dataPatchwork(period,internalStat,dataInput);
                    [model,A]=mainCore.createModel(datiModelli,orderY,u,1);
                end
            result=model;
            return;

            else
            %% part3:  else calculate the prevision
            % i set the data input to zero
            if (isempty(period) || isempty(internalStat) || period==0 ) % no stazionariety
                
                dataNew1{1}=dataInput;
                [unused,A]=mainCore.createModel(dataNew1,orderY,u,0); 
                prevision=flipud(A{1}*model{1});
                if (nStep>1)
                    for i=2:nStep % i cycle the prediction
                        dataNew{1}=service.cutInput(prevision,dataInput.inputdata);
                        [unused,A]=mainCore.createModel(dataNew,orderY,u,0); % this unused is the model created again buy i already have the right model
                        prevision=flipud(A{1}*model{1});
                    end
                end
            else % stazionariety
              
                datiModelli=service.dataPatchwork(period,internalStat,dataInput);
                [unused,A]=mainCore.createModel(datiModelli,orderY,u,0);
                tempdata=datiModelli;
                % i only get the outpudata of tempdata for the stats
                for i=1:length(tempdata)
                    tmp=tempdata{i}.outputdata;
                    tempdata{i}=tmp;
                end
                % calulate the prevision
                prevision=service.multPred(model,A,datiModelli);
                tempred=prevision; % for the stats
                [newResult,lMax]=service.splitData(period,internalStat,prevision);
                prevision=newResult; % i have the prevision
                prevision=prevision'; % row not colums
                if (nStep>1)  % if i have to do more steps
                   % prevision=prevision'; % i want row not colums
                    datiModelli=service.cutInput(prevision,dataInput.inputdata); % the input for the iteration
                    for i=2:nStep % i cycle the prediction
                        datiModelli=service.dataPatchwork(period,internalStat,datiModelli);
                        [unused ,A]=mainCore.createModel(datiModelli,orderY,u,0); %% i already have the model
                        % calulate the prevision
                        prevision=service.multPred(model,A,datiModelli);
                        tempred=prevision; % for the stats
                        [newResult,lMax]=service.splitData(period,internalStat,prevision);
                        prevision=newResult; % i have the prevision
                        prevision=prevision'; % i want row now colums
                        datiModelli=service.cutInput(prevision,dataInput.inputdata); % the input for the iteration
                    end
                    %prevision=prevision'; % rows not columns
                end
            end
            
            %% part3 validate the data
            % now i validate the data
%             prevision(find(validateVectY==1))=NaN;
%             % i wanna reset also when u1 is not good
%             if(u(1)>0)
%                 prevision(find(validateVectU1==1))=NaN;
%             end
%             % i wanna reset also when u2 is not good
%             if(u(2)>0)
%                 prevision(find(validateVectU2==1))=NaN;
%             end
            init=ones(nStep,1)*misvalue;
            result=[init; prevision];
            
            end 
        end
    end % end methods
end %end class