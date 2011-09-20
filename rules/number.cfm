<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "[^[:digit:].-]", "", "all" )>
</cfif>

<cfif NOT isNumeric( arguments.value ) OR NOT reFindNoCase( "^-?[[:digit:]]+(\.[[:digit:]]+)?", arguments.value )>
	<cfif attributes.mutable AND NOT attributes.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "[^[:digit:].-]", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain numbers (0-9), and optionally a decimal and negative symbol">
</cfif>
