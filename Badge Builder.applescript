use scripting additions

--this gives us a list of aliases to each image file
set theImageFileList to choose file with prompt "Choose the image files you want to use" with multiple selections allowed

--set up the source file list

--choose the name file, restrict it to text files
set theNameFile to choose file with prompt "Choose the name file ending in .txt" of type {"public.plain-text"} without multiple selections allowed
--open the file for read access and get a handle/reference to it
set theNameFileHandle to open for access theNameFile without write permission
--read the file contents via the handle
set theNameFileContents to read theNameFileHandle
--close the file
close access theNameFileHandle
--build a list of firstname lastname
set theNameFileList to every paragraph of theNameFileContents


--get an alias to the .indd file
set theBadgeDoc to choose file with prompt "Select the Indesign badge file
you want to use:" of type {"com.adobe.indesign-document"} without multiple selections allowed

--main script loop, happens inside of ID
tell application "Adobe InDesign CC 2019"
	--set the printer preset
	set thePrinterPreset to the first item of (every printer preset whose name is "Badges")
	--get a variable for the InDesign file we're about to use
	set theActiveDoc to open theBadgeDoc
	--this is fragile AF, but it will work. There's not really a better way that doesn't
	--involve loops
	set theNameFrame to the first item of (every text frame of theActiveDoc whose contents is "NAME")
	set theImageLink to the first item of every link of the active document whose name is "imagefilename.jpg"
	
	--the main loop
	repeat with x in theNameFileList
		--set the badge name
		set the contents of theNameFrame to x
		
		--set the image file to match the name
		--build the file name
		set theFileName to the last word of x & ".jpg"
		
		--inner loop to relink the file
		repeat with y in theImageFileList
			--the fastest way to do this is to use info for. The Finder is bog slow
			--and system events is weird in catalina betas
			--if the name matches, we relink and print
			if the name of (info for y) is theFileName then
				--set theImageFile to y as alias
				relink theImageLink to y
				--give us time to load a card into the printer
				--since we've no error handling, hitting 'cancel' will end the script here
				--cheesy, but it works
				display dialog "Ready to print?"
				--print the thing
				print theActiveDoc using thePrinterPreset without print dialog
				--since we're done with this name, there's no point in running the rest of the list
				exit repeat
			end if
		end repeat
	end repeat
	
	-- close without saving so we don't mess things up we may need later
	close theActiveDoc saving no
end tell
