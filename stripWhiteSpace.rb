/Remove Whitespace and comments from file/

/Function below if user wants no comments/
def noComments (line)
        length = line.length
        i = 0
	j = i + 1
	
	/Traverse string looking for an instance of double backslashes/
	while (i < length - 1)
		if (line[i] == "/" && line[j] == "/")
			return FALSE	
		end
		i = i + 1
		j = j + 1		
	end
	/if no comments found, then return TRUE/
	return TRUE
end

/Below I assume the file is the last argument, I check to see if no comments is included/
if (ARGV[1].nil?)
        name = ARGV[0]
        check = 1
else
        name = ARGV[1]
        check = 2
end

/open the file provided and rename target.out/
file = File.open(name)
target = name.chop.chop
target = target.to_s + "out"

/final is the file I write to/
final = File.open("#{target}".to_s, "w") do |f|
        /check==1 means to NOT remove comments, just whitespace/
	if (check == 1)
                while (line = file.gets)
			/gsub removes all whitespace with below parameters/
                        line = line.gsub(/\s+/, "")
                        if (line.length > 0) then
                                f.write "#{line}\n"
                        end
                end
        else /check == 2/
		/if check == 2, then the user wants whitespace and comments removed/
		while (line = file.gets)
                	line = line.gsub(/\s+/, "")
        		/Below I use the noComments method (at top) to check to see if comments are in the line at all/
			if (line.length > 0 && noComments(line) == TRUE)
				f.write "#{line}\n"
			/I then need to look at lines that have code before comments and write that to the new file/
	        	elsif (line.length > 0 && noComments(line) == FALSE)
				
				/The below statment removes the comment wherever it first pops up/
				if (line[0] != "/" && line[1] != "/")
					count = 0
					while (count < line.length && line[count] != "/")
						f.write "#{line[count]}"
						count = count + 1				
					end
					f.write "\n"
				end
			end
		end
        end
end
file.close

