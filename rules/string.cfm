<cfparam name="arguments.noSpaces" type="boolean" default="false">

<cfif arguments.mutable AND arguments.noSpaces>
	<cfset arguments.value = reReplace( arguments.value, "\s", "", "all" )>
</cfif>

<cfif NOT isSimpleValue( arguments.value )>
	<cfif arguments.mutable>
		<cfset arguments.value = "">
	</cfif>
	<cfset arguments.message = "can only be a simple string value">
</cfif>

