<cfparam name="arguments.condition" type="string">
<cfparam name="arguments.conditionError" type="string" default="failed validation">

<cfif evaluate( arguments.condition ) IS false>
	<cfset arguments.message = "#arguments.conditionError#">
</cfif>

