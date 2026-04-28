# Nivra Operator Guide

This document describes how to maintain the Nivra fork.

## Repository Setup
```bash
git clone https://github.com/emperor-777/Nivra.git
cd Nivra
git remote add upstream https://github.com/signalapp/Signal-Android.git
git fetch --all
```

## Branch Strategy
- `upstream-main`: Tracks `upstream/main` directly. Do not commit here.
- `nivra-main`: Integration branch containing Signal-Android core + Nivra flavor overlay.
- `nivra-brand-ui`: Feature branch for customizing UI assets.

## CI/CD Sync Process
A GitHub Action workflow runs daily (or manually) to fetch `upstream/main` and open a PR against `nivra-main`.
- **Safe Paths**: Changes isolated to UI, documentation, and the `nivra` flavor are automatically merged.
- **Protected Paths**: Changes in `crypto/`, `libsignal`, `webrtc`, or `messages` require human review. DO NOT force merge without understanding the upstream security implications.

## Rollback
If an upstream update breaks Nivra:
```bash
git revert <merge-commit-hash>
git push origin nivra-main
```
Do not attempt to hot-patch broken core cryptographic logic. Always revert and test.

## Customizations
Keep all customizations strictly inside `app/src/nivra/` or flavor definitions in `app/build.gradle.kts`. Do not delete or rename upstream classes unless completely unavoidable.
