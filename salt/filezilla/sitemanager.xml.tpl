<?xml version="1.0"?>
<FileZilla3 version="3.58.0" platform="*nix">
	<Servers>
	  {% for server in pillar.filezilla.servers -%}
		<Server>
			<Host>{{ server.host }}</Host>
			<Port>{{ server.port }}</Port>
			<Protocol>0</Protocol>
			<Type>0</Type>
			<User>{{ server.user }}</User>
			<Pass encoding="base64">{{ server.pass }}</Pass>
			<Logontype>1</Logontype>
			<PasvMode>MODE_DEFAULT</PasvMode>
			<EncodingType>Auto</EncodingType>
			<BypassProxy>0</BypassProxy>
			<Name>{{ server.name }}</Name>
			<SyncBrowsing>0</SyncBrowsing>
			<DirectoryComparison>0</DirectoryComparison>
		</Server>
		{%- endfor %}
	</Servers>
</FileZilla3>
