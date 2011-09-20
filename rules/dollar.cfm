<cfparam name="arguments.dollarSign" type="boolean" default="true">
<cfparam name="arguments.allowNegative" type="boolean" default="true">

<cfif arguments.autoFix>
	<cfset arguments.value = trim( reReplace( arguments.value, "[^0-9.\$-]", "", "all" ) )>
</cfif>

<cfif NOT arguments.allowNegative AND find( "-", arguments.value )>
	<cfif arguments.autoFix>
		<cfset arguments.value = replace( arguments.value, "-", "", "all" )>
	</cfif>
	<cfset arguments.message = "can't be a negative amount">
<cfelse>
	<cfset arguments.regex = "[0-9]+\.[0-9]{2,2}$">
	<cfif arguments.dollarSign>
		<cfset arguments.regex = "\$" & arguments.regex>
	</cfif>
	<cfif arguments.allowNegative>
		<cfset arguments.regex = "-?" & arguments.regex>
	</cfif>
	<cfset arguments.regex = "^" & arguments.regex>
	
	<cfif NOT reFindNoCase( arguments.regex, arguments.value )>
		<cfif arguments.mutable AND NOT arguments.autoFix>
			<cfset arguments.value = reReplace( arguments.value, "[^0-9.\$-]", "", "all" )>
		</cfif>
		<cfif arguments.dollarSign>
			<cfset arguments.message = "must be a valid dollar value, like $132.45">
		<cfelse>
			<cfset arguments.message = "must be a valid dollar value, like 132.45">
		</cfif>
	</cfif>
</cfif>
