namespace BookDataGenerator.UI.Models
{
    public class Book
    {
        public int Index { get; set; }
        public string ISBN { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public string Author { get; set; } = string.Empty;
        public string Publisher { get; set; } = string.Empty;
        public string CoverImageUrl { get; set; } = string.Empty;
        public DateTime PublishedDate { get; set; }
        public List<Review> Reviews { get; set; } = new();
        public int Likes { get; set; }
		public string CoverColor { get; set; } = "#4361ee";
	}

    public class Review
    {
        public string ReviewerName { get; set; } = string.Empty;
        public string Content { get; set; } = string.Empty;
        public int Rating { get; set; }
    }
}
