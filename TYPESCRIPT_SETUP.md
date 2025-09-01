# TypeScript Setup Guide for OpenSWE-Source

## Current TypeScript Configuration

Your openswe-source project is already configured with modern TypeScript:

- **TypeScript Version**: 5.7.2 (very current, latest stable is 5.9.2)
- **Target**: ES2021 with ES2023 libraries
- **Module System**: NodeNext (modern ESM/CJS hybrid)
- **Configuration**: Strict TypeScript with all recommended settings

## Package Manager Issue Resolution

The project uses **Yarn 3.5.1** which requires corepack. Here are the setup options:

### Option 1: Enable Corepack (Recommended)
```powershell
# Run as Administrator
corepack enable

# Then in project directory:
cd "d:\local git 2025\cue-verse-beginnings\local main v1 - pre branch merge completion\Priv-cue-staging\ai-stack\openswe-source"
yarn install
yarn build
```

### Option 2: Use NPM Instead (Alternative)
```powershell
# Remove yarn-specific files
rm package-lock.json -ErrorAction SilentlyContinue
rm yarn.lock -ErrorAction SilentlyContinue

# Install with npm
npm install --legacy-peer-deps
npm run build
```

### Option 3: Local Yarn Installation
```powershell
# Install yarn locally without corepack
npm install -g yarn
cd "d:\local git 2025\cue-verse-beginnings\local main v1 - pre branch merge completion\Priv-cue-staging\ai-stack\openswe-source"
yarn install
```

## TypeScript Upgrade to Latest (Optional)

If you want to upgrade to TypeScript 5.9.2 (latest stable):

### Update Root package.json
```json
{
  "devDependencies": {
    "typescript": "^5.9.2"
  }
}
```

### Update Individual Apps
```json
{
  "devDependencies": {
    "typescript": "~5.9.2"
  }
}
```

### Run Upgrade Commands
```powershell
# Update root
yarn add -D typescript@5.9.2

# Update workspaces
yarn workspace @openswe/agent-v2 add -D typescript@5.9.2
yarn workspace @openswe/shared add -D typescript@5.9.2
yarn workspace @openswe/cli add -D typescript@5.9.2
yarn workspace @openswe/web add -D typescript@5.9.2
```

## TypeScript Configuration Files

### Root tsconfig.json (Already Optimized)
```json
{
  "extends": "@tsconfig/recommended",
  "compilerOptions": {
    "target": "ES2021",
    "lib": ["ES2023"],
    "module": "NodeNext",
    "moduleResolution": "nodenext",
    "strict": true,
    "declaration": true,
    "outDir": "dist"
  }
}
```

### App-Specific Configurations
Each app extends the root configuration with specific settings:
- **open-swe-v2**: LangGraph agent with ESM modules
- **shared**: Common utilities and types
- **cli**: Command-line interface
- **web**: Web application components

## Development Workflow

### Build Commands
```powershell
# Build all packages
yarn build

# Build specific package
yarn workspace @openswe/agent-v2 build

# Development mode
yarn dev
```

### Type Checking
```powershell
# Check types across all packages
yarn turbo lint

# Format code
yarn format

# Run tests
yarn test
```

## Advanced TypeScript Features Enabled

Your configuration already includes:
- ✅ Strict type checking
- ✅ Modern ES2021+ features
- ✅ NodeNext module resolution
- ✅ Declaration file generation
- ✅ Unused parameter detection
- ✅ No implicit returns
- ✅ Switch statement validation

## Troubleshooting

### Common Issues
1. **Corepack Permission Error**: Run PowerShell as Administrator
2. **Module Resolution Issues**: Ensure `moduleResolution: "nodenext"`
3. **ESM/CJS Conflicts**: Use `type: "module"` in package.json

### Verification Commands
```powershell
# Check TypeScript version
npx tsc --version

# Validate configuration
npx tsc --noEmit

# Check project structure
yarn turbo build --dry-run
```

## Next Steps

1. **Choose setup option** (corepack recommended for best compatibility)
2. **Run installation** using your chosen method
3. **Verify build** with `yarn build` or `npm run build`
4. **Optional**: Upgrade to TypeScript 5.9.2 for latest features

Your TypeScript setup is already quite modern and well-configured! 🚀
