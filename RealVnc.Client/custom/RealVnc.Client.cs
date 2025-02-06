namespace RealVnc;

public static class CurrentClient
{
	// This property is used to store the current client instance, so that it is accessible across runspaces
	public static Client? Client;
}

public partial class Client
{


	private string authToken;
	public string AuthToken
	{
		set => authToken = value;
	}

	/// <summary>
	/// This is an extensibility point that lets us hook into the request as it goes out. This is where we add the auth token info.
	/// </summary>
	partial void PrepareRequest(HttpClient client, HttpRequestMessage request, string url)
	{
		if (string.IsNullOrWhiteSpace(authToken))
		{
			// Ignore if this is the initial login request
			if (url.EndsWith("1.0/sessions")) return;

			throw new InvalidOperationException("You must set the authToken property before making a request. Use Connect-RealVnc to authenticate");
		}

		// Append the auth token to the request
		request.Headers.Add("Authorization", "Bearer " + authToken);
	}
}