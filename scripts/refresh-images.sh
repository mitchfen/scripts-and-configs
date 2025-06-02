#!/bin/bash

echo "--- Starting Docker image cleanup and refresh ---"

# 1. Prune unused Docker images
# The -a flag removes all unused images, not just dangling ones.
# The -f flag forces the operation without prompting for confirmation.
echo "Pruning all unused Docker images..."
docker image prune -f

# Check if the prune command was successful
if [ $? -ne 0 ]; then
    echo "Error during image pruning. Exiting."
    exit 1
fi

echo "Image pruning complete."

# 2. Get a list of all remaining images (repository:tag format)
# We use --format '{{.Repository}}:{{.Tag}}' to get the clean image name and tag
# We filter out '<none>:<none>' images which are typically intermediate build layers or untagged images.
echo "Listing current Docker images to refresh..."
IMAGES_TO_PULL=$(docker image ls --format '{{.Repository}}:{{.Tag}}' | grep -v '<none>:<none>')

# Check if any images were found
if [ -z "$IMAGES_TO_PULL" ]; then
    echo "No images found to refresh. Exiting."
    exit 0
fi

echo "Images to refresh:"
echo "$IMAGES_TO_PULL"
echo ""

# 3. Pull each image from the list
echo "Pulling (refreshing) each listed Docker image..."
# Loop through each image and attempt to pull it
# The 'read -r image' ensures that lines with spaces are handled correctly
# The '|| true' after 'docker pull' prevents the script from exiting if a single pull fails
# This is useful if you want the script to continue pulling other images even if one fails.
echo "$IMAGES_TO_PULL" | while read -r image; do
    echo "Pulling $image..."
    docker pull "$image" || echo "Warning: Failed to pull $image. Continuing with others."
done

echo "--- Docker image cleanup and refresh complete ---"

