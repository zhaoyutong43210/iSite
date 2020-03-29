function PHYS1030_file_read
folder = dir('*.pdf');
folder  = struct2cell(folder)';


for n = 1:length(folder)
    
 filename = folder{n,1};
 

str = extractFileText(filename);


ind1 = strfind(str,'ABSTRACT');
ind2 = strfind(str,'TITLE');
str = char(str);
Abstract = str(ind1+8:ind2-1);

 Abstract =convertCharsToStrings(Abstract);
 Abstract = erase(Abstract,newline);

 
 WC = regexpi(Abstract,'[a-zA-Z]*');
 word_count = length(WC);
 
 
 if word_count > 150 && word_count < 200
     disp([filename,' world count = ', num2str(word_count)])
     
     str1 = [' -0.25 world count  on abstract is ', num2str(word_count),...
         ' please make it clear and short. You may skip some details on method part.'];
 elseif word_count > 200
      str1 = [' -0.5 world count  on abstract is ', num2str(word_count),...
         ' please make it clear and short. You may skip some details on method part.'];
 else         
     str1 = ['world count  on abstract is ', num2str(word_count),'. The length of this abstract is good. :)'];
 end
 
 
 suggestions = checkWordsSpelling(cellstr(split(Abstract)));
 
if ~isempty(suggestions)
 sugg = strjoin([str1, newline ,' -0.25 Spell check:' suggestions]);
 
else 
    sugg = strjoin([str1, 'Spell is good']);
end
comment  = strjoin([Abstract,newline,newline,sugg]);

 Ftxt = fopen([filename(1:end-4),'.txt'],'w'); 
 fprintf(Ftxt,erase(comment,'%'));
 fclose(Ftxt);
 
 disp([' procees on ',filename,' Finnished'])
end

end

 function suggestion = checkWordsSpelling( words )
    %
    %   Based on Mathworks thread:
    %   http://www.mathworks.com/matlabcentral/answers/91885-is-there-any-way-to-check-spelling-from-within-matlab
    %
    % - Split space-separated words into cell array of words, or wrap
    %  single word into cell array.
    if ischar( words )
        if any( words == ' ' )
            words = strsplit( words, ' ' ) ;
        else
            words = {words} ;
        end
    end
    % - Launch MS Word and create document.
    h = actxserver( 'word.application' ) ;
    h.Document.Add ;
    % - Build cell array of originals and suggestions.
    words  = words(:) ;      % -> columns cell array.
    nWords = numel( words ) ;
    for wId = 1 : nWords
        % - Check if spelling correct. Loop back if so.
        isCorrect    = h.CheckSpelling( words{wId,1} ) ;
        words{wId,2} = isCorrect ;
        if isCorrect
            words{wId,3} = false ;
            continue ;
        end
        % - Build cell array of suggestions.
        nSug = h.GetSpellingSuggestions( words{wId,1} ).count;
        words{wId,3} = nSug > 0 ;
        if nSug > 0
            for sId = 1 : nSug
                words{wId,4}{sId} = ...
                    h.GetSpellingSuggestions( words{wId,1} ).Item(sId).get( 'name' ) ;
            end
        end
    end
    % - Quit MS Word.
    h.Quit
    % - Build table (or struct array if you prefer).
    %wordsChecked = cell2struct( words, {'original', 'isCorrect', 'hasSuggestion', 'suggestion'}, 2 ) ;
    %wordsChecked = cell2table( words, 'VariableNames', {'original', 'isCorrect', 'hasSuggestion', 'suggestion'} ) ; 
    
    ind = find(cell2mat(words(:,2))==0);
    suggestion =strjoin(string(words(ind,1)),' and ');
 end
