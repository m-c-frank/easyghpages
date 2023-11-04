#!/bin/bash

# Helper function to prompt the user for confirmation
ask_to_proceed() {
    read -p "Press ENTER when you're ready to continue."
}

# Fork the repository to your account
gh repo fork m-c-frank/easyghpages --clone=true --remote=true

# Determine the name of the forked repository
REPO_NAME=$(basename $(gh repo view --json name -q .name))

# Get your GitHub username
GITHUB_USERNAME=$(gh api user --jq .login)

# Get your desired custom domain name
read -p "Type the domain name you want to use and press ENTER: " DOMAIN

# Instructions for DNS configuration
echo "Let's set up your domain. Follow these instructions:"
echo "1. Sign in to your domain registrar's website."
echo "2. Find the DNS settings page."
echo "3. Add a CNAME record for 'www' pointing to '${GITHUB_USERNAME}.github.io'."
echo "4. Add A records for the apex domain (e.g., 'yourdomain.com') using GitHub's IP addresses."
echo "GitHub's current IPs are: 185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153."
echo "Changes might take some time to take effect, often up to 48 hours."
ask_to_proceed

# Instructions for enabling GitHub Pages
echo "Now, let's turn on GitHub Pages for your repository."
echo "1. Go to your GitHub repository in a web browser."
echo "2. Click 'Settings', then find 'Pages' in the side menu."
echo "3. Choose the branch you want to deploy, typically 'main' or 'master'."
echo "4. Click 'Save' to activate GitHub Pages."
ask_to_proceed

# Instructions for setting up the custom domain in GitHub
echo "Lastly, we'll connect your domain to GitHub Pages."
echo "1. In the 'Pages' settings, type your custom domain in the 'Custom domain' field."
echo "2. Save, and GitHub will create a CNAME file in your repo."
echo "3. Follow GitHub's instructions to verify your domain if required."
ask_to_proceed

# Switch to the repository directory
cd $REPO_NAME || { echo "Failed to enter the directory for the repository."; exit 1; }

# Personalize the README.md file
sed -i "1s/.*/# ${REPO_NAME} setup by ${GITHUB_USERNAME}/" README.md
git add README.md
git commit -m "Customize README.md"
git push

echo "All done! Your website should be live soon. Check the 'Pages' settings on GitHub to confirm."
