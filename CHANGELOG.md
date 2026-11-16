# Changelog

Each entry lists breaking changes first. Read it before you apply an "update available" notice on Railway.

## 2.4.6-1 (2026-11-16)

- README: add the Deploy on Railway button for the published template (`psitransfer`). No change to the app or the image.

## 2.4.6 (2026-11-16)

- First release of this template: PsiTransfer v2.4.6 (`psitrax/psitransfer:v2.4.6@sha256:382ec8700be82dc348f47d2a20da7557ff106cdcb7614a234eafb2ee301c3efe`).
- Listens on Railway's `PORT`, stores uploads on a volume at `/data`, runs as the image's `node` user (UID 1000).
- Upload and admin passwords are generated at deploy time (`PSITRANSFER_UPLOAD_PASS`, `PSITRANSFER_ADMIN_PASS`).
