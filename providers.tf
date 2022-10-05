provider "google" {
  project = "{PROJECT NAME HERE}"
  region  = "us-east1"
  zone    = "us-east1-b"
  credentials = file("key.json")
}