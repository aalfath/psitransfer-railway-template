# PsiTransfer on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/psitransfer?utm_medium=integration&utm_source=button&utm_campaign=psitransfer)

A Railway template for [PsiTransfer](https://github.com/psi-4ward/psitransfer), a simple self-hosted file sharing app (an open-source alternative to WeTransfer): no accounts, resumable uploads and downloads of large files, expiry times, one-time downloads, password-protected buckets and zip/tar.gz download of a whole bucket.

## What it deploys

One service built from this repo. The `Dockerfile` pins the official image `psitrax/psitransfer:v2.4.6` by digest and adds a small start script (`start.sh`) that:

- maps Railway's `PORT` to PsiTransfer's `PSITRANSFER_PORT`;
- keeps uploads on a Railway volume mounted at `/data`;
- gives a fresh volume to the image's unprivileged `node` user (UID 1000) and runs the app as that user.

Health check: `/`.

## Variables

| Variable | Default | What it does |
|---|---|---|
| `PORT` | `3000` | Port the app listens on (Railway routes the public domain to it) |
| `PSITRANSFER_UPLOAD_PASS` | generated | Password needed to upload. Recipients don't need it to download. Delete the variable to allow anonymous uploads (not recommended on a public URL) |
| `PSITRANSFER_ADMIN_PASS` | generated | Password for the `/admin` page, which lists every bucket |

Every other option in PsiTransfer's [`config.js`](https://github.com/psi-4ward/psitransfer/blob/master/config.js) can be set as an environment variable with the `PSITRANSFER_` prefix, for example `PSITRANSFER_MAX_FILE_SIZE`, `PSITRANSFER_DEFAULT_RETENTION` or `PSITRANSFER_REQUIRE_BUCKET_PASSWORD=true`. See the upstream [configuration docs](https://github.com/psi-4ward/psitransfer/blob/master/docs/configuration.md).

## Updates

New PsiTransfer versions land here as a change to the pinned image in the `Dockerfile`, with an entry in [`CHANGELOG.md`](CHANGELOG.md). When it's merged to `main`, Railway shows everyone who deployed the template an "update available" notice, and you choose when to apply it. Your files stay on the volume.

## Run it locally

```sh
docker build -t psitransfer-railway .
docker run -p 3000:3000 -e PORT=3000 -e PSITRANSFER_UPLOAD_PASS=change-me -e PSITRANSFER_ADMIN_PASS=change-me-too -v psitransfer-data:/data psitransfer-railway
```
