###
#
# 
#
###

class KCMAPIConnection {
	[securestring]$Token
	[string]$BaseURL
	[string]$DataSource
	[bool]$SkipCertificateCheck
	[string]GetToken() {
		return [pscredential]::new("placeholder", $this.Token).GetNetworkCredential().Password
	}
}


####
#
# Connection Object Classes
#
###
#Baseclass containing shared attributes of all connections
class Connection {
    [string]$parentIdentifier
    [string]$name
    [string]$protocol
    [ConnectionAttributes]$attributes
    
    Connection (){
        $this.attributes = [ConnectionAttributes]::new()
    }
}

class ConnectionAttributes {
    #properties
	[String]${max-connections}
	[String]${max-connections-per-user}
	[String]${weight}
	[String]${failover-only}
	[String]${guacd-port}
	[String]${guacd-encryption}
	[String]${guacd-hostname}
	[bool]${ksm-user-config-enabled}
}

#VNC Object
class VNCParameters {
	#network
	[String]${hostname}
	[int]${port}
	
	#authentication
	[String]${password}
	[String]${username}

	#display
	[bool]${read-only}
	[bool]${swap-red-blue}
	[String]${cursor}
	[String]${color-depth}
	[bool]${force-lossless}

	#clipboard
	[String]${clipboard-encoding}
	[bool]${disable-copy}
	[bool]${disable-paste}
	
	#repeater
	[String]${dest-host}
	[String]${dest-port}

	#recording
	[String]${recording-path}
	[String]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}
	
	#sftp	
	[bool]${enable-sftp}
	[String]${sftp-hostname}
	[int]${sftp-port}
	[String]${sftp-host-key}
	[String]${sftp-username}
	[String]${sftp-password}
	[String]${sftp-private-key}
	[String]${sftp-passphrase}
	[String]${sftp-root-directory}
	[String]${sftp-directory}
	[int]${sftp-server-alive-interval}
	[bool]${sftp-disable-download}
	[bool]${sftp-disable-upload}

	#audio
	[bool]${enable-audio}
	[String]${audio-servername}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class VNC : Connection {
    [VNCParameters]$parameters
    VNC(){
        $this.parameters = [VNCParameters]::new()
    }
}

#SSH Object
class SSHParameters {
	#network
	[String]${hostname}
	[int]${port}
	[String]${host-key}

	#authentication
	[String]${username}
	[String]${password}
	[String]${private-key}
	[String]${passphrase}

	#display
	[String]${color-scheme}
	[String]${font-name}
	[int]${font-size}
	[int]${scrollback}
	[bool]${read-only}
	
	#clipboard
	[bool]${disable-copy}
	[bool]${disable-paste}
	[String]${clipboard-encoding}

	#session
	[String]${command}
	[String]${locale}
	[string]${timezone}
	[int]${server-alive-interval}

	#behavior
	[int]${backspace}
	[String]${terminal-type}

	#typescript
	[String]${typescript-path}
	[String]${typescript-name}
	[bool]${create-typescript-path}

	#recording
	[String]${recording-path}
	[String]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}

	#sftp
	[bool]${enable-sftp}
	[String]${sftp-root-directory}
	[bool]${sftp-disable-download}
	[bool]${sftp-disable-upload}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class SSH : Connection {
    [SSHParameters]$parameters
    SSH(){
        $this.parameters = [SSHParameters]::new()
    }
}

#RDP Object
class RDPParameters {
	#network
	[String]${hostname}
	[int]${port}

	#authentication
	[String]${username}
	[String]${password}
	[String]${domain}
	[String]${security}
	[bool]${disable-auth}
	[bool]${ignore-cert}

	#gateway
	[String]${gateway-hostname}
	[int]${gateway-port}
	[String]${gateway-username}
	[String]${gateway-password}
	[String]${gateway-domain}

	#basic-parameters
	[String]${initial-program}
	[String]${client-name}
	[String]${server-layout}
	[String]${timezone}
	[bool]${enable-touch}
	[bool]${console}

	#display
	[int]${width}
	[int]${height}
	[int]${dpi}
	[int]${color-depth}
	[bool]${force-lossless}
	[string]${resize-method}
	[bool]${read-only}

	#clipboard
	[string]${normalize-clipboard}
	[bool]${disable-copy}
	[bool]${disable-paste}

	#device-redirection
	[bool]${console-audio}
	[bool]${disable-audio}
	[bool]${enable-audio-input}
	[bool]${enable-printing}
	[String]${printer-name}
	[bool]${enable-drive}
	[String]${drive-name}
	[bool]${disable-download}
	[bool]${disable-upload}
	[String]${drive-path}
	[bool]${create-drive-path}
	[String]${static-channels}

	#performance
	[bool]${enable-wallpaper}
	[bool]${enable-theming}
	[bool]${enable-font-smoothing}
	[bool]${enable-full-window-drag}
	[bool]${enable-desktop-composition}
	[bool]${enable-menu-animations}
	[bool]${disable-bitmap-caching}
	[bool]${disable-offscreen-caching}
	[bool]${disable-glyph-caching}
	[bool]${disable-gfx}

	#remoteapp
	[String]${remote-app}
	[String]${remote-app-dir}
	[String]${remote-app-args}

	#preconnection-pdu
	[int]${preconnection-id}	
	[String]${preconnection-blob}

	#load-balancing
	[String]${load-balance-info}

	#recording
	[String]${recording-path}
	[String]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-exclude-touch}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}

	#sftp
	[bool]${enable-sftp}
	[String]${sftp-hostname}
	[int]${sftp-port}
	[String]${sftp-host-key}
	[String]${sftp-username}
	[String]${sftp-password}
	[String]${sftp-private-key}
	[String]${sftp-passphrase}
	[String]${sftp-root-directory}
	[String]${sftp-directory}
	[int]${sftp-server-alive-interval}
	[bool]${sftp-disable-download}
	[bool]${sftp-disable-upload}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class RDP : Connection {
    [RDPParameters]$parameters
    RDP(){
        $this.parameters = [RDPParameters]::new()
    }
}

#Telnet object
class TelnetParameters {
	#network
	[String]${hostname}
	[int]${port}

	#authentication
	[String]${username}
	[String]${password}
	[String]${username-regex}
	[String]${password-regex}
	[String]${login-success-regex}
	[String]${login-failure-regex}

	#display
	[String]${color-scheme}
	[String]${font-name}
	[String]${font-size}
	[int]${scrollback}
	[bool]${read-only}

	#clipboard
	[bool]${disable-copy}
	[bool]${disable-paste}

	#behavior
	[int]${backspace}
	[String]${terminal-type}

	#typescript
	[String]${typescript-path}
	[String]${typescript-name}
	[bool]${create-typescript-path}	

	#recording
	[String]${recording-path}
	[String]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class Telnet : Connection {
    [TelnetParameters]$parameters
    Telnet(){
        $this.parameters = [TelnetParameters]::new()
    }
}

#Kubernetes object
class KubernetesParameters {
	#network
	[String]${hostname}
	[int]${port}
	[bool]${use-ssl}
	[bool]${ignore-cert}
	[String]${ca-cert}

	#container
	[String]${namespace}
	[String]${pod}
	[String]${container}
	[String]${exec-command}

	#authentication
	[String]${client-cert}
	[String]${client-key}

	#display
	[String]${color-scheme}
	[String]${font-name}
	[int]${font-size}
	[int]${scrollback}
	[bool]${read-only}

	#behavior
	[int]${backspace}
	
	#typescript
	[String]${typescript-path}
	[String]${typescript-name}
	[bool]${create-typescript-path}	

	#recording
	[String]${recording-path}
	[String]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}
}

class Kubernetes : Connection {
    [KubernetesParameters]$parameters
    Kubernetes(){
        $this.parameters = [KubernetesParameters]::new()
    }
}



#MYSQL object
class MYSQLParameters {
	#network
	[string]${hostname}
	[int]${port}
	[string]${unix-socket}

	#authentication
	[string]${username}
	[string]${password}

	#display
	[String]${color-scheme}
	[String]${font-name}
	[int]${font-size}
	[int]${scrollback}
	[bool]${read-only}

	#database
	[string]${database}
	[bool]${disable-csv-export}
	[bool]${disable-csv-import}

	#clipboard
	[bool]${disable-copy}
	[bool]${disable-paste}

	#typescript
	[string]${typescript-path}
	[string]${typescript-name}
	[bool]${create-typescript-path}

	#recording
	[string]${recording-path}
	[string]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class MYSQL : Connection {
    [MYSQLParameters]$parameters
    MYSQL(){
        $this.parameters = [MYSQLParameters]::new()
    }
}


#Postgres Object
class PostgresParameters {
	#network
	[string]${hostname}
	[int]${port}

	#authentication
	[string]${username}
	[string]${password}

	#display
	[String]${color-scheme}
	[String]${font-name}
	[int]${font-size}
	[int]${scrollback}
	[bool]${read-only}

	#database
	[string]${database}
	[bool]${disable-csv-export}
	[bool]${disable-csv-import}

	#clipboard
	[bool]${disable-copy}
	[bool]${disable-paste}

	#typescript
	[string]${typescript-path}
	[string]${typescript-name}
	[bool]${create-typescript-path}

	#recording
	[string]${recording-path}
	[string]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class Postgres : Connection {
    [PostgresParameters]$parameters
    Postgres(){
        $this.parameters = [PostgresParameters]::new()
    }
}

#sqlserver Object
class SQLServerParameters {
	#network
	[string]${hostname}
	[int]${port}

	#authentication
	[string]${username}
	[string]${password}

	#display
	[String]${color-scheme}
	[String]${font-name}
	[int]${font-size}
	[int]${scrollback}
	[bool]${read-only}

	#database
	[string]${database}
	[bool]${disable-csv-export}
	[bool]${disable-csv-import}

	#clipboard
	[bool]${disable-copy}
	[bool]${disable-paste}

	#typescript
	[string]${typescript-path}
	[string]${typescript-name}
	[bool]${create-typescript-path}

	#recording
	[string]${recording-path}
	[string]${recording-name}
	[bool]${recording-exclude-output}
	[bool]${recording-exclude-mouse}
	[bool]${recording-include-keys}
	[bool]${create-recording-path}

	#wol
	[bool]${wol-send-packet}
	[string]${wol-mac-addr}
	[string]${wol-broadcast-addr}
	[int]${wol-udp-port}
	[int]${wol-wait-time}
}

class SQLServer : Connection {
    [SQLServerParameters]$parameters
    SQLServer(){
        $this.parameters = [SQLServerParameters]::new()
    }
}