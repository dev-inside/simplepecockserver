## SPHS (Simple Peacock-Server for Hitman)

> ### ⚠️ BREAKING CHANGES ⚠️
> In Version 0.1.1, the `/contracts`-volume has been added to the image. You can finally add custom-contracts via this volume. Make shure, that you mount that volume before the update. In 0.1.2 I've added the config.ini. This file contains several options like "show elusive targets" or other useful options.
> The file has to be placed in the root as `/options.ini`.
>
>If you're using the tag `:0.1.0`, then you should update to atleast `:0.1.2`. If you're using the `:latest` tag, then you have just to pull the update.

SPHS (Simple Peacock-Server for Hitman) is a Docker image for Hitman World of Assassination. The difference in this image is as follows:
- It does not automatically fetch the **"latest"** version of Peacock; instead, the user provides Peacock as a ZIP in the volume. This step may initially seem odd, but it gives you as a Hitman player and self-hoster the following advantages:
  - **The version is not baked into the image**, so you don't have to wait for a new image release.
  - **You can use any Peacock version** — the latest, an older release, or a beta.
- The process is quite simple! Just place the appropriate ZIP (e.g., Peacock-v8.4.0-linux.zip) in the _/your/data/Peacock/version_ volume You can find releases on __Peacock's GitHub__: https://github.com/thepeacockproject/Peacock/releases

----
## Volumes
The following volumes are needed to run `SPHS`:
- `options.ini` - The options file contains several QOL-Options like f.a. higlighting an elusive target etc. It's placed in the root folder.
- `userdata` - Contains your userdata for example Steam- or Epic-ID verifiation and your game progress data
- `contracts` - Contains all contracts which can be downloaded automatically or manually by adding custom contracts as `.json`-files
- `contractSessions`- Savefiles (Manually and Automatically)
- `plugins` - Peacock-Plugins which you can find on their Discord-Server or via Github. The default naming-scheme is `<NAME>.plugin.js``
- `version`- This is the volume where you place the Peacock-Zip. The container will automatically unzip and install the version when you start the doker-container.

----

## Installation

Let's move on to installation. To run the container it is advisable to prepare your volumes as follows:

```
🖥️ /your/data/Peacock/
├── 📁 version/
│   ├── 📦 Peacock-v8.4.0-linux.zip   ← the Peacock Linux zip you want
├── 📁 userdata/                      ← Content of your userdata folder
│   ├── epicids/
│   ├── h1/
│   ├── h2/
│   ├── scpc/
│   ├── steamids/
│   └── users/
├── 📁 contracts/                     ← Custom contracts
│   ├── contactid1.json
│   └── contactid2.json
├── 📁 contractSessions/              ← Your Hitman-Save-Files
│   ├── 22-04-autosave.json
│   └── 12-01-autosave.json
└── 📁 plugins/                       ← compatible Peacock plugins (JS files), e.g.:
│   ├── KillEveryoneCampaign.plugin.js
│   └── another-plugin.plugin.js
└── 💾 options.ini                    ← some Peacock-options
```

The server will only start if all volumes are created correctly and the __Peacock-Zip__ is in the right directory! Let's look at the docker-compose.yml with the example "your/data/Peacock".

----
## Build the docker-image
You can build and start the image as follows:
````sh
docker build -t peacockserver . && docker run --name PeacockServer -p 4700:80 \
-v /your/data/Peacock/version:/Peacock/version \
-v /your/data/Peacock/userdata:/Peacock/userdata \
-v /your/data/Peacock/contracts:/Peacock/contracts \
-v /your/data/Peacock/contractSessions:/Peacock/contractSessions \
-v /your/data/Peacock/plugins:/Peacock/plugins \
-v /your/data/Peacock/options.ini:/Peacock/options.ini
--restart unless-stopped peacockserver

````

## docker-compose
I'd provided the docker-image for your convinience already via 
[Dockerhub](https://hub.docker.com/repository/docker/kodemonaut/simplepeacock). You can just use the docker-compose like this: 

```yaml
services:
  peacockserver:
    container_name: PeacockServer
    image: kodemonaut/simplepeacock:latest
    ports:
      - "4700:80"
    volumes:
      - /your/data/Peacock/version:/Peacock/version
      - /your/data/Peacock/userdata:/Peacock/userdata
      - /your/data/Peacock/contracts:/Peacock/contracts
      - /your/data/Peacock/contractSessions:/Peacock/contractSessions
      - /your/data/Peacock/plugins:/Peacock/plugins
      - /your/data/Peacock/options.ini:/Peacock/options.ini
    restart: unless-stopped

```
----

### Powered by the following amazing projects:
- Peacock https://thepeacockproject.org/
- bun.sh https://bun.sh
