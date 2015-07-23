classdef service
    
    properties (SetAccess='public', GetAccess='public')
    end
    
    methods
    end
    
    methods (Static,Access=public)
        % this method is used to load data from a file
        % it return an object iddata where misvalue is a missing value
        function [data]=loadData(fileOut,fileIn1,fileIn2,misvalue,orderU1,orderU2)
        
            
            if (isempty(fileOut))
                fprintf('\n -- ERRORE: nome file parte AR non specificato');
                return;
            else
                y=load(fileOut,'ASCII');
                y(find(y==misvalue))=NaN;
            end
            
            emptyu1=isempty(fileIn1);
            if (orderU1~=0) % if u1 has a order
                if (~emptyu1)
                    u1=load(fileIn1,'ASCII');
                    u1(find(u1==misvalue))=NaN;
                else
                    u1=ones(length(y),1);
                end
            else
                u1=[];
            end
            emptyu2=isempty(fileIn2);
            if (orderU2~=0) % if u1 has a order
                if (~emptyu2)
                    u2=load(fileIn2,'ASCII');
                    u2(find(u2==misvalue))=NaN;
                else
                    u2=ones(length(y),1);
                end
            else
                u2=[];
            end
            
            
            data=iddata(y,[u1 u2]);
            
        end
        
        % this method split the result depending on the stazionarety
        function [data,l] = splitData(period,internalStaz,dataY)
            
            ll=[];
            % i take the first because they have same length
            for i=1:length(dataY)
                templ=length(dataY{i});
                ll=[ll;templ];
            end
            % i get the max length of dataY
            l=max(ll);
            lsum=sum(ll);
            
            vectIndex=mod([1:l]-1,period);
            %from 0 to 23 each index
            
            if (internalStaz(end)<period)
                internalStaz=[internalStaz period];
            end
            
            if (internalStaz(1)>0)
                internalStaz=[0 internalStaz]; % 0 8 13 18 24
            end
            
            %% start prova
            vectIndex2=mod([1:lsum]-1,period);
            length(vectIndex2);
            datafinal=zeros(1,lsum);
            for k=1:length(internalStaz)-1 % for each stazionariety
                indici=((vectIndex2>=internalStaz(k)) & (vectIndex2<internalStaz(k+1))); % set the index
                tempindex=1;
                for m=1:length(datafinal)
                    if(indici(m)==1) && tempindex<length(dataY{k}) % i put it if i didnt finish datafinal
                        datafinal(m)=dataY{k}(tempindex);
                        tempindex=tempindex+1;
                    end
                end
            end
            
            data=datafinal;
            
        end
        
        % this method create the parallel vector used to
        % store the index of the NaN data
        function [vectVal,vectZero] = valVector(dataIn,nstep)
            v=zeros(1,length(dataIn));
            v(find(isnan(dataIn)))=1;
            ll=length(v);
            for i=1:nstep % the number of prediction step
                v(find(v==1)+1)=1;
            end
            v=v(1:ll);
            
            vectVal=v;
            
            v=dataIn;
            %% i removed this for now!!!!!!      v(find(isnan(dataIn)))=0;
            vectZero=v;
        end
        
        % this method is used to calculate the prediction each step
        function pred = multPred(model,A,datiModelli)
            lM=length(model);
            lD=length(datiModelli);
            
            if (lM~=lD)
                disp('different lenght of data and model');
                return;
            end
            
            % for each model and data
            for i=1:lM
                resultTemp{i}=A{i}*model{i};
                resultTemp{i}=flipud(resultTemp{i});
            end
            
            pred=resultTemp;
        end
        
        % this method create the delay for a signal
        function data = delay(input, amount)
            data=[input(amount+1:end)' zeros(1,amount)];
            data=data'; % i want columnt value
        end
        
        % this methos adjust the lenght of the input corresponding to
        % length(prevision)
        function data = cutInput(prevision, inputData)
            size1=size(inputData);
            inputSize=size1(2);
            linput=size1(1);
            lprev=length(prevision);
            initial=linput-lprev+1;
            
            if inputSize==0 % no u1 and u2
                temp=zeros(length(prevision),1);
            elseif inputSize==1 % only u1
                temp=inputData(initial:end);
            elseif inputSize==2 % u1 and u2
                temp(:,1)=inputData(initial:end,1);
                temp(:,2)=inputData(initial:end,2);
            else % wrong input size
                disp('wrong input size');
                inputSize
                return;
            end
            
            data=iddata(prevision,temp);
            
        end
        % this method return a vector of iddata where each part rappresent
        % the data for a model of each stazionarety
        function data = dataPatchwork(period,internalStaz,dataInput)
            
            l=length(dataInput.outputdata);
            vectIndex=mod([1:l]-1,period);
            % faccio da 0 a 23 ogni indice
            
            if (internalStaz(end)<period)
                internalStaz=[internalStaz period];
            end
            
            if (internalStaz(1)>0)
                internalStaz=[0 internalStaz]; % 0 8 13 18 24
            end
            
            for i=1:length(internalStaz)-1
                indici=find((vectIndex>=internalStaz(i)) & (vectIndex<internalStaz(i+1)));
                data{i}=iddata(dataInput.outputdata(indici),dataInput.inputdata(indici,:));
                % no more misdata
                %data{i}=misdata(data{i});
            end
        end
        
        % this method create the string rappresenting the model
        function mod = createModStr(model,guidata,viewdata)
            delay_u1=guidata.delay_u1;
            delay_u2=guidata.delay_u2;
            %len=length(menu_help);
            len=length(model);
            
            %if isempty(menu_help)
            if isempty(viewdata.model)
                return;
            end
            
            for i=1:len % for each model I create string that rapresent the model of each stationariety
                mody=[];
                %menu_help{i};
                viewdata.model{i};
                n_c=[];
                n_ciclo=sprintf('\nmodel %d:\n',i);
                n_c=[n_c, n_ciclo];

                if(guidata.orderY>0)
                    for j1=1:guidata.orderY
                        %tempy=[num2str(menu_help{i}(j)) '*y(t-' int2str(j) ') + '] ;
                        tempy=[num2str(viewdata.model{i}(j1)) '*y(t-' int2str(j1) ') + '] ;
                        mody=[mody tempy];
                    end
                end

                modu1=[];
            %    n=0;
                n=delay_u1;
                if(guidata.orderU1>0)
                  %  for j=guidata.orderY:guidata.orderY+guidata.orderU1
                  j1=j1+1;
                    for j2=j1:guidata.orderU1+j1-1
                        n=n+1;
                        %tempu1=['+ ' num2str(menu_help{i}(j)) '*u1(t-' int2str(n) ') '];
                        tempu1=['+ ' num2str(viewdata.model{i}(j2)) '*u1(t-' int2str(n) ') '];
                        modu1=[modu1 tempu1];
                    end
                end

                modu2=[];
            %    n=0;
                n=delay_u2;
                if (guidata.orderU2>0)
                    j2=j2+1;
                    %for j=guidata.orderY+guidata.orderU1:guidata.orderY+guidata.orderU1+guidata.orderU2
                    for j3=j2:guidata.orderU2+j2-1
                        n=n+1;
                        %tempu2=['+ ' num2str(menu_help{i}(j)) '*u2(t-' int2str(n) ') '];
                        tempu2=['+ ' num2str(viewdata.model{i}(j3)) '*u2(t-' int2str(n) ') '];
                        modu2=[modu2 tempu2];
                    end
                end

                %mod{i}=[ n_c mody(1:end-2) modu1 modu2];

                %%%%%%%
                %
                depolariz=model{1}(end);
                dep=['+ ' num2str(depolariz)];
                err=' + e(t)';
                mod{i}=[ n_c mody(1:end-2) modu1 modu2 dep err];
                %
                %%%%%%%
                mod{i}(1:end);
            end
        end
        
        %%  statistics methods
        function ret = meanError ( stimata,effettiva )
            error=effettiva-stimata;
            ret = nanmean(error); % nanmean(error)
        end
        
        % return the number of data used
        function ret = nrData(stimata,effettiva ,nStep)
            ret=0;
            effettiva=service.setNan(effettiva,nStep);
            tmp=effettiva-stimata;
            tmp=service.cleanNan(tmp);
            ret=length(tmp)+nStep-1; % for the initial step
        end
        
        function ret = sqMed ( stimata,effettiva )
            %error=stimata-effettiva;
            error=effettiva-stimata;
%             error=error.*error; % quad of error
%             num=error-service.meanError(stimata,effettiva);
%             ret=sqrt(nansum(num)/length(error));
            ret=nanstd(error);
        end
        
        function ret = corrVP (stimata, effettiva )
            stim_norm=stimata-nanmean(stimata);
            eff_norm=effettiva-nanmean(effettiva);
            num=nansum(stim_norm.*eff_norm); 
            den=sqrt(nansum(stim_norm.^2)*nansum(eff_norm.^2)); 
            ret=num/den;
        end
        
        function ret = varrErrore ( stimata, effettiva,nStep )
            %error=stimata-effettiva;
            %stimata=service.cleanNan(stimata);
            %effettiva=service.cleanNan(effettiva)
            effettiva=service.setNan(effettiva,nStep);
            error=effettiva-stimata;
            error=service.cleanNan(error);
            effettiva=service.cleanNan(effettiva);
        ret=nanvar(error)/nanvar(effettiva); 
        end
        
        % this method invalidate the data depending on the number of step
        function ret = setNan(input,nStep)
        tmp=zeros(length(input),1); % vector used to set nan
            for i=1:length(input)
                    if(isnan(input(i)))
                        j=i+1;
                        for z=1:nStep % nStep time i set the nan in tmp
                            tmp(j)=NaN;
                            j=j+1;
                        end
                    end
            end
            
            ret=input-tmp;
        
        end
            
        function ret = cleanNan (input,misvalue)
                tmp=[];
                for i=1:length(input)
                    if (isnan(input(i)))
                        ;
                    else
                        tmp=[tmp;input(i)];
                    end
                end
                ret=tmp;
        end
        
        % this method calculate the various errors
        % if stazio=1 then there is a cyclostationariety process
        % err are the stats error is the error 
        function [err error] = calErrors(stimata,effettiva,stazio,misvalue, nStep)
            if (stazio==0)
                % adjust the data
              %  effettiva(find(isnan(effettiva)))=0;
              %  stimata(find(isnan(stimata)))=0;
              %how much to cut
              tmp=[];
              for i=1:length(stimata)
                  if (stimata(i)==misvalue)
                      ;
                  else
                      tmp=[tmp;stimata(i)];
                  end
              end
              stimata=tmp;
              start=length(effettiva)-length(stimata);
              effettiva=effettiva(start+1:length(effettiva));
              error=effettiva-stimata;
              % effettiva=service.valerror(stimata,effettiva);
                % calculating stats
                err{1}=service.meanError ( stimata,effettiva );
                err{2}=service.sqMed ( stimata,effettiva );
                err{3}=service.corrVP (stimata, effettiva );
                err{4}=service.varrErrore (stimata, effettiva, nStep);
                err{5}=service.nrData ( stimata, effettiva, nStep  );
            else % stationariety
                % initialize err
                err{1}=[];
                err{2}=[];
                err{3}=[];
                err{4}=[];
                err{5}=[];
                for i=1:length(stimata)
                    % adjust the data
                    tmp=[];
                    for j=1:length(stimata{i})
                        if (stimata{i}(j)==misvalue)
                            ;
                        else
                            tmp=[tmp;stimata{i}(j)];
                        end
                    end
                    stimata{i}=tmp;
                    start=length(effettiva{i})-length(stimata{i});
                    effettiva{i}=effettiva{i}(start+1:length(effettiva{i}));
                    %                     effettiva{i}=effettiva{i}(1:length(stimata{i}));
%                     effettiva{i}=service.valerror(stimata{i},effettiva{i});
                    
                    % calculating stats
                    tmp=service.meanError ( stimata{i},effettiva{i} );
                    err{1}=[err{1}; tmp ];
                    tmp=service.sqMed ( stimata{i},effettiva{i} );
                    err{2}=[err{2}; tmp];
                    tmp=service.corrVP (stimata{i}, effettiva{i} );
                    err{3}=[err{3}; tmp];
                    tmp=service.varrErrore ( stimata{i},effettiva{i}  );
                    err{4}=[err{4}; tmp];
                    tmp=service.nrData ( effettiva{i} ,nStep);
                    err{5}=[err{5}; tmp];
                end
            end
            
        end
        
        % this method set to 0 the error where data is a 0
        function err = valerror(data,terror)
            for i=1:length(data)
                if(data(i) == 0)
                    terror(i)=0;
                end
            end
            err=terror;
        end
        
        function ret = maxstep(guidata)
        % the max step is min of delay in the input if there is any
        u1=0;
        u2=0;
        if (guidata.orderU1>0)
            u1=1;
        end
        if (guidata.orderU2>0)
            u2=1;
        end
        
        % set the delay
        if( u1==1 && u2==1)
            ret=min(guidata.delay_u1,guidata.delay_u2)+1;
        end
        if (u1==1 && u2==0)
            ret=guidata.delay_u1+1;
        end
        if (u1==0 && u2==1)
            ret=guidata.delay_u2+1;
        end
        if (u1==0 && u2==0)
            ret=99;
        end
  
        end
    end
end


