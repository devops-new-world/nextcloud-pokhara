
Name: Deploy Nextcloud

on:
  push:
    branches:
      - 'feature/nextcloud-sijan'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: setup ssh host
        run: |
          echo "Hello...."
