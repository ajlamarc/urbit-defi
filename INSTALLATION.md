## Install the dYdX v4 frontend

Note that the dYdX v4 self-hosted frontend is **not available in certain locations (at the time of writing this, at least US and Canada)**. Attempting to access the self-hosted frontend in these locations will result in the frontend failing to fully connect. See the official dYdX Terms and Conditions and use at your own risk.

- Visit [here](https://redhorizon.com/join/e5cdcd14-446c-4a89-9151-d3d1811fd03c) and enter an email and the OTP.
- Select an Urbit ID from the available options and click continue.
- Copy the access key and click "Launch Urbit".  Paste in the access key at the login prompt.
- You should automatically be directed to the dYdX v4 frontend.
  - The self-hosted dYdX v4 frontend is also available on your mobile device, using the same URL currently open, and access key copied in the previous step.

### No available Urbit IDs

- If there are no available Urbit IDs at the above link, please contact [@ajlamarc](https://x.com/ajlamarc) and we will add more.  You may also launch one of Red Horizon's default Urbit IDs and install the dYdX v4 frontend as a separate step [by following the instructions in this video](https://www.loom.com/share/f3ba379261a642feac0b8ad210a70936?sid=09b3c1a1-b6e2-4e5b-ab8e-cf5bfe917ef6).

## Full self-hosting

Following the above instructions, you now have an Urbit managed and hosted by Red Horizon (a Chorus One company). I recommend keeping it here, as they cover server costs and provide update support 100% free at the time of writing.

### Self-hosting options

If you're looking for maximum security, you can export your Urbit from Red Horizon and self-host in multiple places: from your local computer via a CLI, from a Native Planet device, or your own VPS (Digital Ocean Droplet or equivalent).

- CLI: maximum security, runs on your local computer, also 100% free.  Requires a more technical understanding of Urbit and can't be accessed via mobile.
- Native Planet: also maximum security, runs on a dedicated computer for your Urbit.  Less technical, can be accessed via mobile, but you have to buy one of Native Planet's devices.
- VPS: Less secure since your cloud provider could censor.  Have to pay monthly cloud costs; would only recommend this over Red Horizon if you need more control over your Urbit (such as the ability to distribute apps).

### How to self-host

- On redhorizon.com, under "My Urbit" open the "More" dropdown and select Master Ticket.
- Read the instructions, select "Reveal Master Ticket", and save it somewhere secure.
- Go back, and in the dropdown, now select "Export" and read the instructions.  Click "Export" and then click "OK".  It may take 1-2 minutes to prepare your export.  If it appears to be stuck, refresh the page and select "Export" again.
- Download the export file (may be up to 500 MB - 1 GB).
- For your chosen self-hosting path, follow the relevant instructions to run your Urbit in the new location: [Native Planet](https://www.nativeplanet.io/), [Local CLI](https://docs.urbit.org/manual/getting-started/self-hosted/cli), or [VPS](https://docs.urbit.org/manual/getting-started/self-hosted/cloud-hosting).
  - The downloaded file from Red Horizon is compressed by `zstd`.  [You can decompress the file on Unix machines following the answer here.](https://stackoverflow.com/a/45704163). If you need to move the downloaded file to your VPS or Native Planet device, recommend to do that before decompressing.

## Other notes

- Once you have installed the self-hosted frontend, it is yours and can be run forever, even if the developer distribution is terminated.  It currently depends on the same indexer / APIs as `dydx.trade`, however that can be changed with a new release.
- Updates will be released much less frequently than the centralized interface. To see which version of the self-hosted frontend you have installed:
  - Hover over the installed tile in "Landscape", click the three lines, icon, and see the `Last Software Update` date and `Version`. The version numbers match those in the [dydxprotocol/v4-web](https://github.com/dydxprotocol/v4-web/releases) repository. (If you access dYdX v4 at `https://<URL>/apps/dydx-v4/`, landscape is available at `https://<URL>/apps/landscape/`.)
- Contact [@ajlamarc](https://x.com/ajlamarc) to report any installation problems of this self-hosted frontend.
