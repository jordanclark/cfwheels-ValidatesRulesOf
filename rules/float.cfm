<cfif arguments.autoFix>
	<cfset arguments.value = reReplace( arguments.value, "[^0-9.-]", "", "all" )>
</cfif>

<cfif NOT isNumeric( arguments.value ) OR NOT reFindNoCase( "^-?[0-9]+(\.[0-9]+)?$", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplace( arguments.value, "[^0-9.-]", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain decimal numbers like 132.45">
</cfif>


