import { NextResponse } from 'next/server'
import { cookies } from 'next/headers'

export async function POST(request: Request) {
  const formData = await request.formData()
  const password = formData.get('password')

  if (password === process.env.ADMIN_PSW) {
    (await cookies()).set('admin-psw', password, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      maxAge: 60 * 10,
      path: '/',
    })

    return NextResponse.json({ success: true })
  }

  return NextResponse.json(
    { success: false },
    { status: 401 }
  )
}