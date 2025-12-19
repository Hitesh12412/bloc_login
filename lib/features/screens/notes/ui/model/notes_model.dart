class NotesResponse {
  final int status;
  final NotesData data;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  NotesResponse.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'],
        data = NotesData.fromJsonMap(json['data']),
        totalPages = json['totalPages'],
        totalCount = json['totalCount'],
        pageNumber = json['pageNumber'],
        hasNextPage = json['hasNextPage'],
        hasPreviousPage = json['hasPreviousPage'],
        message = json['message'];
}

class NotesData {
  final List<Note> unPinnedNoteList;
  final List<Note> pinnedNoteList;

  NotesData.fromJsonMap(Map<String, dynamic> json)
      : unPinnedNoteList = List.from(json['unPinnedNoteList'])
      .map((e) => Note.fromJsonMap(e))
      .toList(),
        pinnedNoteList = List.from(json['pinnedNoteList'])
            .map((e) => Note.fromJsonMap(e))
            .toList();
}

class Note {
  final int id;
  final String createdBy;
  final String updatedBy;
  final String userId;
  final String title;
  final String description;
  final String isPinned;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final List<NoteMedia> media;

  Note.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        userId = json['user_id'],
        title = json['title'],
        description = json['description'],
        isPinned = json['is_pinned'],
        status = json['status'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'],
        media = List.from(json['media'])
            .map((e) => NoteMedia.fromJsonMap(e))
            .toList();
}

class NoteMedia {
  final int id;
  final String media;
  final String mediaType;

  NoteMedia.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        media = json['media'],
        mediaType = json['media_type'];
}
