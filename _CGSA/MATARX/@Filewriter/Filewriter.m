% this class is used to record the model and the input data
classdef Filewriter < handle
% Property data is private to the class
   properties (SetAccess = private, GetAccess = private)
      FileID
   end % properties

   methods
   % Construct an object and 
   % save the file ID  
      function obj = Filewriter(filename) 
         obj.FileID = fopen(filename,'a');
      end
 
      function writeToFile(obj,text_str)
          fprintf(obj.FileID,'%s\n',text_str);
      end
      
      function writeToFileD(obj,text_str)
          fprintf(obj.FileID,'%f\n',text_str);
      end
      % Delete methods are always called before a object 
      % of the class is destroyed 
      function delete(obj)
         fclose(obj.FileID);
      end 
   end  % methods
end % class