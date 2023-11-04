#!/bin/bash

# Function to print a step and ask for confirmation
confirm_step() {
    echo "$1"
    read -p "Have you completed this step? (y/n): " RESPONSE
    if [[ $RESPONSE != "y" ]]; then
        echo "Please complete this step to proceed."
	confirm_step()
    fi
}

# Introduction
echo "This script will guide you through setting up your markdown file with GitHub Pages and a custom domain."

# Step 1: Confirm domain setup on Namecheap
confirm_step "Step 1: Confirm you have a custom domain set up on Namecheap or another DNS provider."

# Step 2: DNS Configuration Steps on Namecheap
echo "Step 2: DNS Configuration Steps on Namecheap:"
confirm_step " 2.1. Log in to your Namecheap account and navigate to the Dashboard."
confirm_step " 2.2. Click on 'Manage' next to your domain."
confirm_step " 2.3. Access the 'Advanced DNS' tab."
confirm_step " 2.4. Add a CNAME record with Host as 'www' and Value as '<your-github-username>.github.io'."
confirm_step " 2.5. For the apex domain, add A records with Host as '@' and Value as GitHub's IP addresses."
confirm_step " 2.6. Save the DNS changes and wait for them to propagate (up to 48 hours)."

# Step 3: GitHub Pages Activation
echo "Step 3: Manual Activation of GitHub Pages:"
confirm_step " 3.1. Navigate to your GitHub repository."
confirm_step " 3.2. Go to 'Settings' and locate the 'Pages' section."
confirm_step " 3.3. Select the branch to deploy and save your settings."
confirm_step " 3.4. Enter your custom domain in the 'Custom domain' field and save."

# Ask for GitHub details
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter the repository name: " REPO_NAME
read -p "Enter your custom domain: " DOMAIN
read -p "Enter the path to your markdown file: " MARKDOWN_FILE

# Clone the repository
git clone https://github.com/$GITHUB_USERNAME/$REPO_NAME.git
cd $REPO_NAME || exit

# Add and commit markdown file
git add "$MARKDOWN_FILE"
git commit -m "Add markdown file"
confirm_step "The markdown file has been added to the repository."

# Push to GitHub
git branch -M main
git remote set-url origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git
git push -u origin main
confirm_step "The changes have been pushed to the GitHub repository."

# Add CNAME for custom domain
echo $DOMAIN > CNAME
git add CNAME
git commit -m "Configure custom domain"
git push
confirm_step "The CNAME file created and pushed. Your custom domain is now set up."

echo "Setup is complete. Please check your GitHub Pages settings to ensure everything is configured correctly."
