function PHYS1050_file_compile
current_path = pwd;

folder = dir('*.pdf');
folder  = struct2cell(folder)';

[status, msg, ~] = mkdir('report_folder_renamed');
if msg
    disp(msg)
end
for n = 1:length(folder)
    
 filename = folder{n,1};
ind = strfind(filename,'-');

time = filename(ind(end-1)+1:ind(end)-1);
file_Rename = filename(ind(end)+2:end);

 source = [current_path,'\',filename];
 destination = [current_path,'\report_folder_renamed\',file_Rename];
copyfile(source,destination)
end
end 
