import { NextResponse, type NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  const path = request.nextUrl.pathname

  if (path.startsWith('/admin')) {
    const auth = request.cookies.get('admin-psw')
    
    if (auth?.value !== process.env.ADMIN_PSW) {
      return NextResponse.redirect(new URL('/login', request.url))
    }
  }

  return NextResponse.next()
}