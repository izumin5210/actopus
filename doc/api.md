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
 * name of the department
 * Example: `"電気情報工学科"`
 * Type: string
* course
 * name of the course
 * Example: `"情報工学コース"`
 * Type: string
* overseas_student
 * true if the lecture is held for overseas students
 * Example: `false`
 * Type: boolean
* times
 * Type: array
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
 * time when the period start
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
* before
 * Type: object
* after
 * Type: object

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
      "department": "電気情報工学科",
      "course": "情報工学コース",
      "overseas_student": false,
      "times": [
        {
          "id": 1,
          "name": "1",
          "start_time": "09:00:00+09:00",
          "end_time": "10:30:00+09:00"
        }
      ],
      "lecturers": [
        {
          "id": 1,
          "name": "新井 イスマイル"
        }
      ]
    },
    "before": {
      "start_time": "2014-12-01T09:00:00+09:00",
      "end_time": "2014-12-01T10:30:00+09:00"
    },
    "after": {
      "start_time": "2014-12-04T14:40:00+09:00",
      "end_time": "2014-12-04T16:10:00+09:00"
    }
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
* started_on
 * date when the term start
 * Example: `"2014-10-01"`
 * Type: string
* ended_on
 * date when the term end
 * Example: `"2015-03-31"`
 * Type: string

