import SwiftUI

struct BookCover: View {
    let book: Book
    let width: CGFloat
    let height: CGFloat
    
    init(book: Book, width: CGFloat = 100, height: CGFloat = 150) {
        self.book = book
        self.width = width
        self.height = height
    }
    
    var progressPercentage: CGFloat {
        guard book.totalPages > 0 else { return 0 }
        return CGFloat(book.currentPage) / CGFloat(book.totalPages)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            if let image = try? book.loadCoverImage() {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .overlay(
                        ProgressRing(
                            progress: Double(progressPercentage),
                            color: Color.purple,
                            lineWidth: 4,
                            size: 32
                        )
                        .foregroundColor(.purple)
                        .padding(4),
                        alignment: .bottomTrailing
                    )
            } else {
                Image(systemName: "book.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .foregroundColor(.gray)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(8)
                    .overlay(
                        ProgressRing(
                            progress: Double(progressPercentage),
                            color: Color.purple,
                            lineWidth: 4,
                            size: 32
                        )
                        .foregroundColor(.purple)
                        .padding(4),
                        alignment: .bottomTrailing
                    )
            }
            
            Text(book.title)
                .font(.caption)
                .lineLimit(1)
                .frame(width: width)
            
            Text(book.author)
                .font(.caption2)
                .foregroundColor(.gray)
                .lineLimit(1)
                .frame(width: width)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // New book (0% progress)
        BookCover(
            book: Book(
                title: "The Great Gatsby",
                author: "F. Scott Fitzgerald",
                totalPages: 180,
                currentPage: 50,
                externalReference: ["openLibraryKey": "OL6749322M"]
            )
        )
        
        // Book in progress (50%)
        BookCover(
            book: Book(
                title: "1984",
                author: "George Orwell",
                totalPages: 328,
                currentPage: 164,
                externalReference: ["openLibraryKey": "OL24382006M"]
            )
        )
        
        // Almost finished book (90%)
        BookCover(
            book: Book(
                title: "Dune",
                author: "Frank Herbert",
                totalPages: 412,
                currentPage: 371,
                externalReference: ["openLibraryKey": "OL1532343M"]
            )
        )
        
        // Completed book (100%)
        BookCover(
            book: Book(
                title: "The Hobbit",
                author: "J.R.R. Tolkien",
                totalPages: 295,
                currentPage: 295,
                externalReference: ["openLibraryKey": "OL27479W"]
            )
        )
    }
    .padding()
} 
