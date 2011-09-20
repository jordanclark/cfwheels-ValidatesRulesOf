<cfparam name="arguments.extension" type="string" default="">

<cfif reFindNoCase( "[\\/:\*\?""<>\|]", arguments.value )>
	<cfif arguments.mutable>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "[\\/:\*\?""'<>\|]", "", "all" )>
	</cfif>
	<cfset arguments.message = "is invalid, a file name must not contain any of these characters: /<':*?""\|>">
	
<cfelseif len( arguments.extension ) AND NOT reFindNoCase( arguments.extension, listLast( arguments.value, "." ) )>
	<cfset arguments.message = "is invalid, a file name must have the extension .#arguments.extension#">

</cfif>
