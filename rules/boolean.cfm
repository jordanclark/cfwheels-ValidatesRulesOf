<cfparam name="arguments.booleanType" type="string" default="trueFalse">
<cfset arguments.booleanType = replace( arguments.booleanType, "_", "" )>

<cfif isBoolean( arguments.value )>
	<cfif arguments.autoFix>
		<cfif arguments.booleanType IS "truefalse">
			<cfif arguments.value IS true>
				<cfset arguments.value = "true">
			<cfelse>
				<cfset arguments.value = "false">
			</cfif>
		<cfelseif arguments.booleanType IS "yesNo">
			<cfif arguments.value IS true>
				<cfset arguments.value = "yes">
			<cfelse>
				<cfset arguments.value = "no">
			</cfif>
		<cfelseif arguments.booleanType IS "onOff">
			<cfif arguments.value IS true>
				<cfset arguments.value = "on">
			<cfelse>
				<cfset arguments.value = "off">
			</cfif>
		<cfelseif arguments.booleanType IS "bit">
			<cfif arguments.value IS true>
				<cfset arguments.value = "1">
			<cfelse>
				<cfset arguments.value = "0">
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfif arguments.mutable>
		<cfset arguments.value = "">
	</cfif>
	<cfif arguments.booleanType IS "truefalse">
		<cfset arguments.message = "can only be a ""true"" or ""false""">
	<cfelseif arguments.booleanType IS "yesNo">
		<cfset arguments.message = "can only be a ""yes"" or ""no""">
	<cfelseif arguments.booleanType IS "onOff">
		<cfset arguments.message = "can only be a ""on"" or ""off""">
	<cfelseif arguments.booleanType IS "bit">
		<cfset arguments.message = "can only be a ""1"" or ""0""">
	</cfif>
</cfif>

