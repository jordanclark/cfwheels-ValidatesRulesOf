<cfparam name="arguments.case" type="string" default="">

<cfif arguments.mutable>
	<cfif arguments.case IS "upper">
		<cfset arguments.value = uCase( arguments.value )>
	<cfelseif arguments.case IS "lower">
		<cfset arguments.value = lCase( arguments.value )>
	</cfif>
</cfif>
