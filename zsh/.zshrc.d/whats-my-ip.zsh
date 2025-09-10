# show ip address
function myipis() {
	response=$(curl -s https://api.ipify.org/)

	# Check if response is not empty
	if [ -n "$response" ]; then
	    echo "Your public IP address is: $response"
	else
	    echo "Failed to retrieve IP address. Please check your internet connection."
	fi
}
