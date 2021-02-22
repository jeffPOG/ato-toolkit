param (
    [Parameter(Mandatory=$true)] [DeploymentType] $DeploymentType,
    [Parameter(Mandatory=$true)] [string] $AdminUsername,
    [Parameter(Mandatory=$true)] [string] $AppName,
    [Parameter(Mandatory=$true)] [string] $AppUrl,
    [Parameter(Mandatory=$true)] [string] $BastionMachineName,
    [Parameter(Mandatory=$true)] [string] $ContainerRegistry,
    [Parameter(Mandatory=$true)] [string] $ContainerTag,
    [Parameter(Mandatory=$true)] [string] $DatabaseName,
    [Parameter(Mandatory=$true)] [string] $JiraVersion,
    [Parameter(Mandatory=$true)] [string] $PostgresHostname,
    [Parameter(Mandatory=$true)] [string] $PostgresPassword,
    [Parameter(Mandatory=$true)] [string] $ResourceGroup,
    [Parameter(Mandatory=$true)] [string] $StorageClass,
    [Parameter(Mandatory=$true)] [string] $AccessMode,
    [Parameter(Mandatory=$true)] [string] $SshKey,
    [Parameter(Mandatory=$true)] [string] $SubscriptionId,
    [Parameter(Mandatory=$true)] [string] $TenantId,
    [Parameter(Mandatory=$false)] [string] $BastionProxyUsername,
    [Parameter(Mandatory=$false)] [string] $BastionProxyIp
)

$parameterJson = @"
{
    "name": "parameters",
    "parameters": [
        {
            "name": "namespace",
            "source": {
                "value": "$AppName"
            }
        },
        {
            "name": "app-url",
            "source": {
                "value": "$AppUrl"
            }
        },
        {
            "name": "jira_release",
            "source": {
                "value": "$AppName"
            }
        },
        {
            "name": "url",
            "source": {
                "value": "$ContainerRegistry/$AppName/$AppName"
            }
        },
        {
            "name": "version",
            "source": {
                "value": "$JiraVersion"
            }
        },
        {
            "name": "tag",
            "source": {
                "value": "$ContainerTag"
            }
        },
        {
            "name": "storageClass",
            "source": {
                "value": "$StorageClass"
            }
        },
        {
            "name": "accessMode",
            "source": {
                "value": "$AccessMode"
            }
        },
        {
            "name": "postgres_release",
            "source": {
                "value": "$($DatabaseName)-jira"
            }
        },
        {
            "name": "postgres_registry",
            "source": {
                "value": "$ContainerRegistry"
            }
        },
        {
            "name": "postgres_repository",
            "source": {
                "value": "$AppName/$DatabaseName"
            }
        },
        {
            "name": "postgres_hostname",
            "source": {
                "value": "$PostgresHostname"        
            }
        },
        {
            "name": "postgres_password",
            "source": {
                "value": "$PostgresPassword"
            }
        }
    ]
}
"@

$IsInsecureRegistry = $false

if ($DeploymentType -eq [DeploymentType]::DisconnectedLite)
{
    $IsInsecureRegistry = $true
}
Log-Information "Logging in to az cli for tenant [$TenantId] and subscription [$SubscriptionId]"
Confirm-DsopAzLogin `
    -TenantId $TenantId `
    -SubscriptionId $SubscriptionId `
    -DeploymentType $DeploymentType`

Install-PorterFromBastion `
    -DeploymentType $DeploymentType `
    -AppName $AppName `
    -ContainerRegistry $ContainerRegistry `
    -ResourceGroup $ResourceGroup `
    -BastionMachineName $BastionMachineName `
    -AdminUsername $AdminUsername `
    -SshKey $SshKey `
    -BastionProxyUsername $BastionProxyUsername `
    -BastionProxyIp $BastionProxyIp `
    -ParameterJson $parameterJson `
    -IsInsecureRegistry:$IsInsecureRegistry







# SIG # Begin signature block
# MIIIZwYJKoZIhvcNAQcCoIIIWDCCCFQCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU8KXxjioQRrsk/ebkbKAy5cXI
# bnSgggUEMIIFADCCAuigAwIBAgIQFaxo6DEMNq5Bd3mHM4/5BzANBgkqhkiG9w0B
# AQsFADAYMRYwFAYDVQQDDA1KZXJlbXlPbGFjaGVhMB4XDTIwMDgzMTIxMTUxMFoX
# DTIxMDgzMTIxMjQ1OVowGDEWMBQGA1UEAwwNSmVyZW15T2xhY2hlYTCCAiIwDQYJ
# KoZIhvcNAQEBBQADggIPADCCAgoCggIBAJu5Y9YhmKGhwU+/kj7dsj1OvrliwUCe
# kdPsfdTAPh9peuKKF+ye8U3l3UT8luf5nCYlG/eKe5YxI3pBYhfZwy7yKZpsx5Tn
# ST7t38owgktj0W6YYfoDgfR4zwLtRk3taNWiZeyHu/UhszNs4d3L9wl6Ei/otfRt
# jyz1UO40361YWriD43jbnsCLjVpIfiwW2LH1H9cVoCLnbMZ217rpVxDiTlFPBGeW
# Bk2pxPn5Z2Ly1j6q/SlliEOKDXXrPQZz+sSc3L/ZXBl7D2/ua4+xJmDw/XE1GUBA
# Pldde/IHAzmp6lHHgdQLjCaks//cucDeYBzVTD8XZo8T9WIWU6o6I6SRzGKSIHcX
# SoKVy1hjaW14wJHImw/nlnCgDLMcBBpnRFo6UHAAUzpWlcgqCC+johdXVSa62+hP
# bLwgqfm6uty0rJRwkhbm1Qi0w6HOUZiIkBIz/5Q83t9nLhWL+uWndKIe9BiVfl1f
# x0p5Ax5hzWD5PV1rjrXSQLpL9PRLKcEAy7EoXa/5VGGKSAOrUZdey39vL3AOct0w
# i3vh49DTfWXuxxHbiWz2VEIZqNWQu/rIi9uiCvzaFUo19DwSZrv1ac+OOmZsloqB
# yDugGWFmxiQjEFWtGxEqwDXPDsJE/gKEPvUha37YCI6iQTtcwiwJpnPfGWODqUHH
# 0/NuToVp4ci5AgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggr
# BgEFBQcDAzAdBgNVHQ4EFgQU16Rx2qHCuXNeExsbMFbSE/Io0NYwDQYJKoZIhvcN
# AQELBQADggIBAG+8jfz9QCzSUK5WGIW0gnEK3rN8oxmSax7C6HJfGPMLXHBEWtBt
# ZCeD8XXkTMu8fhvQDseGgxJ4NmRR+s1d8YtnVgtDbEhO/FHSpOPonTvIx13t37Uz
# Tbvq0ZLeB6z55noAOIhXBs9or1pzxio71sDNfYpIB6s41X5/m1UZk8toxcPDqQGL
# Kg3C3xqgg9+2kQ16flYKvZh2UoK5Y0EyEb8rMc+6AFH3GgcP7yoUsUENP9vkLbXm
# 2VRMIzd/Tee7oKQK50K1GxtlWLUUjuAUMCQh+9K/JyAUro9jfMNHCGcPTaayXBvl
# kaCOjb1IrKgtsS/c2p7mgbssdFHHGPBlbggogGFxYof+6SDI2YB8AqT3RYJdJH4c
# 6StsYUka1faCYcZfz+DIm2+avSCKdliOb285WT8yqoh7P2qN6bLt2au0IsfUKR+d
# EgSL3waCmT+xUI6BI6mpnSjgA0/Hr6I/wkxHu/hk0G0q4OdBpXpSzCzurKPdQWB+
# K/PaQSCyEGk4IGqFrHMx863mtW+mlm6jCM/5/b5ugAmF4XoNkVzdmfFhepqq4h0v
# ioKE+1sLxgq2lFtKAZMjpJB7HZ9KVQcb/hSYlgms/mG6P+4GIhf7ZfvlI2LsCdbV
# 42kEAfDVDuHcCqWyJr43vm+vY6xzjDRnNmaqVJgH1sZO0kwajDOKkm/JMYICzTCC
# AskCAQEwLDAYMRYwFAYDVQQDDA1KZXJlbXlPbGFjaGVhAhAVrGjoMQw2rkF3eYcz
# j/kHMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqG
# SIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3
# AgEVMCMGCSqGSIb3DQEJBDEWBBSnoquYgjuXDKPgsGEC63Q6OzkZ7zANBgkqhkiG
# 9w0BAQEFAASCAgAqCYRZSJ5UsNt59PMr/DeTYr5pCJyg3VTit2goGiNzcG0QSyqP
# SWNqGL1q7icium4ZjnYrCnL6HsuQQipOh1rYmaIriuV+9Qd0in6ZsnPHf3bKebem
# ElDcPfkClhvuuyh14WJVBY2Mxn6eQg5xgS9uyZ9C+DnvoP5nXauLLUolqVx0mv8Z
# kfLtPXNh0O966IP/G/Dbwtzcnut7pxW1VY7rOk8s4TkZ9MMiR6KWNxUW6nMxnP3e
# oS5rEXoO26RYGX9eSC5ZNKmOHJqiBHdCydoMV/t983SU/jJjdBapA3pzKSqPCKjH
# pdXbppy3CO70veguLNUw4bh+8XR6Zz8oTOcvD7f8XJJahiR1hZ+YaTJw2I1Luqde
# +FxOJa/+KxaKEZABCEejrIIjfKOxrvQKTIZVADI1d1wMMRGWLELqHceKJ9gxkYp4
# PzWhRs8cxGMe8UnuvAo4W0UBMDsrqcEOzGwzliSLniOWThBVW97ZXkJ6YiTByioR
# Q/qWtXLUrEWjQt6fGLgRFM8XTM3Q0U04LOu9++BOsfFpCraTGzAj3hbBFSbV20GF
# Q/zhpvX14mNLJF0qfeAyh4YNm0q8IZQjzUNwATqZaBNi/XQxVM9o8WNNzP02WrdT
# GB6rHV/K7GpjHOb5XQ6UcrGF0ZAi9zxSw5VdOC2gFSMuSX1IvYXoj6hORg==
# SIG # End signature block
