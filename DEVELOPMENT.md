# dYdX Urbit Frontend development

## Compile

As well as the web frontend, the shared "abacus" Kotlin Multiplatform code contains references to paths of images and configuration JSON files for the frontend. Since Urbit hosts the dYdX frontend and its files at `/apps/dydx-v4/` instead of `/`, these references must be updated as well.

1. Clone the `v4-web`, `v4-abacus`, and `urbit-defi` repositories into the same folder on your local machine.

```bash
mkdir dydx-v4-urbit && cd dydx-v4-urbit
git clone https://github.com/ajlamarc/v4-web.git
git clone https://github.com/ajlamarc/v4-abacus.git
git clone https://github.com/ajlamarc/urbit-defi.git
```

1. `git checkout` the `dydx-v4-urbit` branch from the `v4-web` and `v4-abacus` repositories.
2. Follow the installation process for [v4-abacus](https://github.com/ajlamarc/v4-abacus/tree/dydx-v4-urbit) for required dependencies (Java 11) and verify your install.
3. Install [homebrew](https://brew.sh/) and `gradle` with `brew install gradle`.
4. In the `v4-web` repository folder, install pnpm and NPM packages from the instructions [here](https://github.com/ajlamarc/v4-web/tree/dydx-v4-urbit#part-1-setting-up-your-local-environment).
5. Run the `install-local-abacus` command in the `v4-web` repository folder, following the instructions [here](https://github.com/ajlamarc/v4-web/tree/dydx-v4-urbit#local-abacus-development). This may take a few minutes.
6. Compile the v4-web frontend with `pnpm run build`. This will output build files to the `/dist` folder in `v4-web`.
7. Install the Urbit binary to your local machine by following steps 1 and 2 of the instructions on [this page](https://docs.urbit.org/manual/getting-started/self-hosted/cli). I recommend doing this at the `dydx-v4-urbit` folder level that we created earlier.
8. Create a "fake ship" (a locally-running Urbit server) with the `./urbit -F zod` command, using the Urbit binary executable downloaded in the previous step. This will take 5-10 minutes to boot from scratch. When completed, the `~zod:dojo>` prompt will be displayed and allow command entry. A `zod` folder will be created containing all files corresponding to that Urbit ship (planet).
   1. The Urbit terminal will print out `http: web interface live on http://localhost:8080` (or likely, port 80 if developing on MacOS). Visit that URL in a browser to verify that the server is available - it will display a login screen.
   2. In the Urbit terminal, enter the `+code` command to retrieve the password. Copy-and-paste the output (likely `lidlut-tabwed-pillex-ridrup`) to login to the fake `zod`.
9. Run the following commands in the Urbit terminal to create a new "desk" named `%dydx-v4`, where files can be consumed and distributed by the Urbit server. `|mount` will make the desk files available on your local filesystem.

```
~zod:dojo> |new-desk %dydx-v4
~zod:dojo> |mount %dydx-v4
```

11. Leave the Urbit terminal running and open a new terminal in the `v4-web` repository. Copy the `/dist` folder to the `dydx-v4` desk folder:

```bash
# optional: remove existing dist folder if rebuilding the interface
v4-web $: rm -r ../zod/dydx-v4/dist
# copy to Urbit folders
v4-web $: cp -r dist ../zod/dydx-v4
```

12. In the Urbit prompt, commit these changes, and compile the dist folder to a single `.glob` file that Urbit expects:

```
~zod:dojo> |commit %dydx-v4
~zod:dojo> -landscape!make-glob %dydx-v4 /dist
```

13. This will create a new `.glob` file in the `zod/.urb/put` subdirectory named something like `glob-0v7.chgip.a9vau.kc5nh.pcau5.vmh45.glob`. The `0v7.chgip.a9vau.kc5nh.pcau5.vmh45` portion of the name is the file hash, used by Urbit to verify the download for security purposes. Copy the hash, replacing the previous glob's hash with the new one in the `desk.docket-0` file located at `urbit-defi/dydx-v4/desk.docket-0`, under the `glob-http` key. Also, update the `version` to match the built version of the `v4-web` repository.

```
:~
  title+'dYdX v4'
  info+'Trading, decentralized (and self-hosted)'
  color+0x69.66fb
  version+[1 3 12]
  website+'https://dydx.exchange'
  license+'MIT'
  image+'https://dydx-v4-urbit.s3.amazonaws.com/dydx-logo.jpg'
  base+'dydx-v4'
  glob-http+['https://dydx-v4-urbit.s3.amazonaws.com/dydx-v4-urbit.glob' <REPLACE PREVIOUS HASH WITH NEW HASH HERE>]
==
```

14. Rename the `.glob` file to `dydx-v4-urbit.glob` in preparation for deployment.

## Update

### Update dYdX frontend (Web / Abacus version)

1. Merge the upstream changes into the local branch for both repositories and handle any merge conflicts.
2. Look in the merged changes (view between commits on Github) for any new assets added, renamed, etc. in the `public` folder of `v4-web` and write those down.
3. In both `v4-abacus` and `v4-web`, search for references to those new assets. If they point to an absolute path such as `/currencies/aave.png`, we will need to replace (prepend) `/apps/dydx-v4` to their path, since that is the location they will be available on the Urbit hosted site.
4. Recommended to run `pnpm dev` in `v4-web` to verify on the locally running site that the assets render as expected (check the console for any errors).
5. Follow the Compile and Deploy instructions on this README.

### Update Urbit kelvin version

Urbit itself occasionally releases major version updates which all applications must declare compatibility with, otherwise new users will be unable to install said application.

You may want to read more about the different types of Urbit updates on [this page](https://operators.urbit.org/manual/os/updates#kernel-updates).

1. In the [urbit-dev](https://groups.google.com/a/urbit.org/g/dev) Google group, Kelvin updates will be announced alongside migration instructions. Follow all other migration comments from the announcement as described.
2. Follow the "new desk" instructions [here](https://developers.urbit.org/guides/core/app-school-full-stack/8-desk), replacing `journal` with `dydx-v4`, to pull the latest desk files for the new kelvin version from the `landscape` and `urbit` repositories. Node that we don't want to delete _all_ files from the `dydx-v4` folder, just everything except the `desk.ship`, `desk.docket-0`, and `sys.kelvin` file (delete the `lib`, `mar`, and `sur` folders).
   1. Make sure the copied library files are for the new kelvin version, which may not be in the main branch of each of those repositories. Check `develop` or whichever branch contains the dev files.
3. Edit `sys.kelvin`, replacing the number with the new kelvin version.
4. Follow the Deploy instructions with the new `dydx-v4` desk files. Since the `glob` file was not changed, the Compile instructions can be skipped.

## Deploy

You will need:

- An AWS account for S3 access
- A Digital Ocean droplet for running the Urbit distribution planet (described in the below instructions).
- Ownership of an Urbit planet
  - If you have a managed, hosted "planet" from Red Horizon or Tlon, recommended to ask them for help ejecting. Deploying apps via Urbit requires full control of the server that the Urbit is running on, which most hosting providers do not support.

1. In the `urbit-defi/dydx-v4/desk.ship` file, replace its contents with the ship name you will use to distribute the application.
2. Create a new S3 bucket if you don't already have one (I named mine dydx-v4-urbit).
3. Apply a public read access policy to the bucket, replacing `dydx-v4-urbit` in the `Resource` field with the name of your bucket:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::dydx-v4-urbit/*"
        }
    ]
}
```

4. In the bucket, upload `dydx-logo.jpg` (available in this repository's root) and `dydx-v4-urbit.glob` (created in the compile instructions).
5. In `dydx-v4/desk.docket-0` in this repository, update the links for `image` and `glob-http` to the object URL / download link for the files from the S3 console.
6. Follow Urbit's official [cloud hosting instructions](https://operators.urbit.org/manual/running/hosting) with Digital Ocean to create a droplet and run your Urbit on the cloud.
   1. I reccomend using [FreeDNS](https://freedns.afraid.org/) to create a subdomain to access your Urbit instead of what is described on the official cloud hosting documentation.
7. If your Urbit does not already have a `%dydx-v4` desk, create a new one with `|new-desk %dydx-v4` and `|mount %dydx-v4`. Remove the `dydx-v4` folder from your Urbit, as we will replace it with the files we want to deploy.
8. Create a tarball file of the latest dydx-v4 desk files (the `dydx-v4` folder in this repository), `scp` it to your Digital Ocean droplet, uncompress it on the droplet, and move the `dydx-v4` folder to the correct place in the ship's files (you removed the original copy of this folder in step 4).
9. In the Urbit terminal, run the following commands to publish the app / update:

```
|commit %dydx-v4
:treaty|publish %dydx-v4
```
