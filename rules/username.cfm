<!--- only contain letters, numbers, underscore, hyphens, must start with a letter and end with a letter or number --->
<cfif reFindNoCase( "[^a-z0-9_\-]", arguments.value )>
	<cfif arguments.autoFix>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "[^a-z0-9_\-]", "", "all" )>
	</cfif>
	<cfset arguments.message = "must begin with a letter, and can only contain: letters and numbers plus underscores or hyphens">
</cfif>

