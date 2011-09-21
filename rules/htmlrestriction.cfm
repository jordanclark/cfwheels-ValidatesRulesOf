<cfparam name="arguments.allowTags" type="string" default="B,STRONG,EM,I,FONT,UL,OL,LI,BR,P,DIV,SPAN,ADDRESS">

<cfset arguments.htmlTagsRegex = replace( arguments.allowTags, ",", "|", "all" )>

<cfif arguments.autoFix>
	<cfset arguments.value = reReplaceNoCase( arguments.value, "<[/!]?(#arguments.htmlTagsRegex#)[^>]*>", "", "all" )>
</cfif>

<cfif len( arguments.value ) AND ( find( "<", arguments.value ) OR find( ">", arguments.value ) )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = htmlEditFormat( arguments.value )>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "&lt;(/?)(#arguments.htmlTagsRegex#)([^(&gt;)]*)&gt;", "<\1\2\3>", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain these HTML tags: #replace( arguments.htmlTags, ',', ', ', 'all' )#">
</cfif>
