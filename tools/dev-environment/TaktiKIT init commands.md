[[🏛️ ארכיטקטורה מומלצת ל-OffGridOps]]
[[Tactical Ai Project Stack]]

```
PS TaktiKIT> winget install Schniz.fnm
PS TaktiKIT> New-Item -Path $PROFILE -Type File -Force
PS TaktiKIT> notepad $PROFILE
fnm env --use-on-cd | Out-String | Invoke-Expression
restart terminal
PS TaktiKIT> fnm --version
fnm 1.39.0
PS TaktiKIT> fnm install --lts
PS TaktiKIT> fnm default lts-latest
PS TaktiKIT> fnm env --use-on-cd | Out-String | Invoke-Expression
PS TaktiKIT> fnm default 24
PS TaktiKIT> fnm use 24
Using Node v24.21.0
(node -v > .nvmrc)
PS TaktiKIT> node -v | Out-File -FilePath .nvmrc -Encoding utf8
PS TaktiKIT> Get-Content .nvmrc
v24.21.0
PS TaktiKIT> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
PS TaktiKIT> npm install -g pnpm
npm notice New major version of npm available! 11.19.0 -> 12.1.0
PS TaktiKIT> npx create-nx-workspace@latest offgrid-ops-monorepo --preset=ts --packageManager=pnpm
Which code formatter would you like to use?
prettier
Speed up GitHub Actions, GitLab CI, and more with Nx Cloud?
Skip for now
Help improve Nx by sharing your usage data?
│  No
PS TaktiKIT> cd .\offgrid-ops-monorepo\
PS TaktiKIT\offgrid-ops-monorepo> New-Item -ItemType Directory -Path "tools/dev-environment" -Force
PS TaktiKIT\offgrid-ops-monorepo> Copy-Item $PROFILE -Destination "tools/dev-environment/Microsoft.PowerShell_profile.ps1"
create setup-env.ps1
PS TaktiKIT\offgrid-ops-monorepo> Copy-Item ..\.nvmrc -Destination ".nvmrc"
BASH TaktiKIT\offgrid-ops-monorepo (main)
$ git add .
BASH TaktiKIT\offgrid-ops-monorepo (main)
$ git config --global user.email "you@example.com"
BASH TaktiKIT\offgrid-ops-monorepo (main)
$ git config --global user.name "Your Name"
BASH TaktiKIT\offgrid-ops-monorepo (main)
$ git commit -m "initial commit. feat(devops): add powershell profile and environment onboarding scripts"
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
PS TaktiKIT\offgrid-ops-monorepo> 
```