# API
ANCT reschedulings API

* [Course](#course)
* [Department](#department)
* [Lecture](#lecture)
* [Lecturer](#lecturer)
* [Period](#period)
* [Rescheduling](#rescheduling)
 * [GET /reshedulings](#get-reshedulings)
* [Term](#term)

## Course


### Properties
* id
 * unique identifier of the course
 * Example: `1`
 * Type: integer
* name
 * name of the course
 * Example: `"情報工学コース"`
 * Type: string

## Department


### Properties
* id
 * unique identifier of the department
 * Example: `1`
 * Type: integer
* name
 * name of the department
 * Example: `"電気情報工学科"`
 * Type: string

## Lecture


### Properties
* id
 * unique identifier of lecture
 * Example: `1`
 * Type: string
* name
 * name of the lecture
 * Example: `"プログラミング I"`
 * Type: string
* grade
 * grade of students taking the lecture
 * Example: `1`
 * Type: integer
* department
 * Type: object
* course
 * Type: object
* overseas_student
 * true if the lecture is held for overseas students
 * Example: `false`
 * Type: boolean
* periods
 * Type: array
* term
 * Type: object
* lecturers
 * Type: array

## Lecturer


### Properties
* id
 * unique identifier of the lecturer
 * Example: `1`
 * Type: integer
* name
 * name of the lecture
 * Example: `"新井 イスマイル"`
 * Type: string

## Period


### Properties
* id
 * unique identifier of the period
 * Example: `1`
 * Type: integer
* name
 * name of the period
 * Example: `"1"`
 * Type: string
* start_time
 * time when the period begin
 * Example: `"09:00:00+09:00"`
 * Type: string
* end_time
 * time when the period end
 * Example: `"10:30:00+09:00"`
 * Type: string

## Rescheduling


### Properties
* id
 * unique identifier of the resheduling
 * Example: `1`
 * Type: integer
* category
 * variations of reshedulings(change, cancel, extra)
 * Example: `"change"`
 * Type: string
* lecture
 * Type: object
* start_time_before_rescheduling
 * start time of the lecture before resheduled
 * Example: `"2014-12-01T09:00:00+09:00"`
 * Type: string
 * Format: date-time
* end_time_before_rescheduling
 * end time of the lecture before resheduled
 * Example: `"2014-12-01T10:30:00+09:00"`
 * Type: string
 * Format: date-time
* start_time_after_rescheduling
 * start time of the lecture after resheduled
 * Example: `"2014-12-04T14:40:00+09:00"`
 * Type: string
 * Format: date-time
* end_time_after_rescheduling
 * end time of the lecture after resheduled
 * Example: `"2014-12-04T16:10:00+09:00"`
 * Type: string
 * Format: date-time

### GET /reshedulings
List existing reshedulings.

```
GET /reshedulings HTTP/1.1
Host: api.akashi.ac.jp
```

```
HTTP/1.1 200
Content-Type: application/json
[
  {
    "id": 1,
    "category": "change",
    "lecture": {
      "id": 1,
      "name": "プログラミング I",
      "grade": 1,
      "department": {
        "id": 1,
        "name": "電気情報工学科"
      },
      "course": {
        "id": 1,
        "name": "情報工学コース"
      },
      "overseas_student": false,
      "periods": [
        {
          "id": 1,
          "name": "1",
          "start_time": "09:00:00+09:00",
          "end_time": "10:30:00+09:00"
        }
      ],
      "term": {
        "id": 1,
        "name": "前期",
        "begin_at": "2014-10-01",
        "end_at": "2015-03-31"
      },
      "lecturers": [
        {
          "id": 1,
          "name": "新井 イスマイル"
        }
      ]
    },
    "start_time_before_rescheduling": "2014-12-01T09:00:00+09:00",
    "end_time_before_rescheduling": "2014-12-01T10:30:00+09:00",
    "start_time_after_rescheduling": "2014-12-04T14:40:00+09:00",
    "end_time_after_rescheduling": "2014-12-04T16:10:00+09:00"
  }
]
```

## Term


### Properties
* id
 * unique identifier of term
 * Example: `1`
 * Type: integer
* name
 * name of the term
 * Example: `"前期"`
 * Type: string
* begin_at
 * date when the term begin
 * Example: `"2014-10-01"`
 * Type: string
* end_at
 * date when the term end
 * Example: `"2015-03-31"`
 * Type: string

