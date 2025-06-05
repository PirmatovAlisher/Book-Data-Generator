using Bogus;
using BookDataGenerator.UI.Models;

namespace BookDataGenerator.UI.Services
{
	public class BookService
	{
		public List<Book> GenerateBooks(int count, int offset, string locale,
			double avgLikes, double avgReviews, long userSeed)
		{
			var books = new List<Book>();
			for (int i = 0; i < count; i++)
			{
				var bookSeed = (int)(userSeed + offset + i);
				var faker = new Faker(locale)
				{
					Random = new Randomizer(bookSeed)
				};

				books.Add(GenerateBook(faker, offset + i + 1, avgLikes, avgReviews));
			}
			return books;
		}

		private Book GenerateBook(Faker faker, int index, double avgLikes, double avgReviews)
		{
			var title = faker.Lorem.Sentence(faker.Random.Int(2, 4));
			var author = faker.Name.FullName();

			return new Book
			{
				Index = index,
				ISBN = faker.Commerce.Ean13(),
				Title = title,
				Author = author,
				Publisher = faker.Company.CompanyName(),
				CoverImageUrl = GenerateCoverImageUrl(faker),
				CoverColor = faker.Internet.Color(),
				PublishedDate = faker.Date.Past(5),
				Likes = CalculateCount(avgLikes, faker),
				Reviews = GenerateReviews(faker, avgReviews)
			};
		}

		private int CalculateCount(double avg, Faker faker) =>
			(int)Math.Floor(avg) + (faker.Random.Double() < (avg % 1) ? 1 : 0);

		private List<Review> GenerateReviews(Faker faker, double avgReviews)
		{
			var count = CalculateCount(avgReviews, faker);
			return Enumerable.Range(0, count).Select(_ => new Review
			{
				ReviewerName = faker.Name.FullName(),
				Content = string.Join(" ", faker.Lorem.Sentences(faker.Random.Int(1, 3))),
				Rating = faker.Random.Int(1, 5)
			}).ToList();
		}

		private string GenerateCoverImageUrl(Faker faker)
		{
			var imageId = faker.Random.Int(1, 1000);
			return $"https://picsum.photos/id/{imageId}/600/800";
		}
	}
}