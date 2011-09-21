<!--- <cfparam name="arguments.exclude" type="boolean" default="true"> --->
<cfparam name="arguments.zipFakes" type="string" default="00000,11111,22222,33333,44444,55555,66666,77777,88888,99999,12345,54321">

<cfif listFind( arguments.zipFakes, left( arguments.value, 5 ) )>
	<cfset arguments.message = "is not a valid zip code, please don't enter a fake number">
</cfif>
